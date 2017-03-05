class User < ActiveRecord::Base
  after_create :send_welcome_mail
  after_create :notify_slack_of_new_user if Rails.env.production?
  has_many :assignments
  has_many :roles, through: :assignments

  has_many :user_interests
  has_many :interests, through: :user_interests
  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true

  has_many :comments, dependent: :destroy

  has_many :user_hackrooms
  has_many :hackrooms, through: :user_hackrooms

  has_many :hackroom_owners
  has_many :own_hackrooms, through: :hackroom_owners, source: :hackroom

  has_many :user_languages
  has_many :languages, through: :user_languages

  has_many :user_primaries
  has_many :primary_languages, through: :user_primaries, source: :language

  has_many :event_rsvps
  has_many :events, through: :event_rsvps

  has_one :organiser_interest

  has_many :sponsorship_admins
  has_many :sponsors, through: :sponsorship_admins

  has_many :managed_events, through: :sponsors, source: :events

  mount_uploader :image, AvatarUploader
  mount_uploader :logo, LogoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :update }

  scope :listed, -> { where(listed: true) }

  scope :with_role, lambda { |role| joins(:roles).where(roles: { name: role }) }

  scope :organiser, -> { with_role("Organiser") }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.github = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      user.bio = auth.extra.raw_info.bio
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

  private

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_now
  end

  def notify_slack_of_new_user
    Slacked.post_async slack_message, channel: 'new-signups', username: 'New User Bot'
  end

  def slack_message
    profile_url = Rails.application.routes.url_helpers.user_path(self)
    "#{name} signed up to the site! http://westlondoncoders.com#{profile_url}"
  end
end
