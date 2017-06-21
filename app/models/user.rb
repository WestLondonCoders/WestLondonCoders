class User < ActiveRecord::Base
  after_create :notify_slack_of_new_user if Rails.env.production?

  has_many :assignments, dependent: :destroy
  has_many :roles, through: :assignments
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :user_hackrooms
  has_many :hackrooms, through: :user_hackrooms
  has_many :hackroom_owners
  has_many :own_hackrooms, through: :hackroom_owners, source: :hackroom
  has_many :user_languages
  has_many :languages, through: :user_languages
  has_many :user_primaries
  has_many :primary_languages, through: :user_primaries, source: :language
  has_many :meetup_rsvps, dependent: :destroy
  has_many :meetups, through: :meetup_rsvps
  has_many :sponsorship_admins, dependent: :destroy
  has_many :sponsors, through: :sponsorship_admins
  has_many :managed_meetups, through: :sponsors, source: :meetups
  has_many :posts, foreign_key: :created_by_id, dependent: :destroy
  has_many :user_follows, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :user_follows, source: 'user'
  has_many :followings, class_name: "UserFollow", foreign_key: "user_id", dependent: :destroy
  has_many :followers, through: :followings, source: 'follower'
  has_many :notifications, dependent: :destroy
  has_many :likes

  mount_uploader :image, AvatarUploader
  mount_uploader :logo, LogoUploader

  scope :in_popularity_order, -> { order('user_follows_count desc') }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :update }

  scope :listed, -> { where(listed: true) }
  scope :with_role, lambda { |role| joins(:roles).where(roles: { name: role }) }
  scope :organiser, -> { with_role("Organiser") }
  scope :oldest_first, -> { order('created_at desc') }

  def all_hackrooms
    (own_hackrooms.all + hackrooms.all).uniq
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      first_name, last_name = split_name(auth.info.name)
      user.first_name = first_name
      user.last_name = last_name
      user.github = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      user.bio = auth.extra.raw_info.bio || ''
      user.username = auth.info.nickname
    end
  end

  def has_social_links?
    social_link = twitter || facebook || github || instagram || linkedin || website_url
    social_link.present?
  end

  def is_hackroom_admin?(hackroom)
    own_hackrooms.include? hackroom
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def self.split_name(user_full_name)
    user_full_name.split
  end

  def colour
    primary_languages&.first&.colour || languages&.first&.colour || '#000000'
  end

  def label
    name
  end

  def already_likes(this)
    likes.where(likeable: this).first
  end

  def score
    score = 0
    score += followers.count * 10
    score += completed_steps.count * 50
    score
  end

  private

  def notify_slack_of_new_user
    Slacked.post_async slack_message, channel: 'new-signups', username: 'New User Bot'
  end

  def slack_message
    profile_url = Rails.application.routes.url_helpers.user_path(self)
    "#{name} signed up to the site! http://westlondoncoders.com#{profile_url}"
  end
end
