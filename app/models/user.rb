class User < ActiveRecord::Base
  has_many :assignments
  has_many :roles, through: :assignments

  has_many :user_interests
  has_many :interests, through: :user_interests
  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true

  has_many :user_skills
  has_many :skills, through: :user_skills
  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true

  has_many :comments, dependent: :destroy

  has_many :user_hackrooms
  has_many :hackrooms, through: :user_hackrooms

  has_many :hackroom_owners
  has_many :own_hackrooms, through: :hackroom_owners, source: :hackroom

  has_many :user_languages
  has_many :languages, through: :user_languages

  has_many :user_primaries
  has_many :primary_languages, through: :user_primaries, source: :language

  mount_uploader :image, AvatarUploader
  mount_uploader :logo, LogoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.username = auth.info.nickname
      user.github = auth.info.nickname
      user.image = auth.info.image
      user.password = Devise.friendly_token[0,20]
      user.permission = 10
      user.bio = auth.extra.raw_info.bio
    end
  end

  def has_social_links?
    return true if twitter.present? ||
                   facebook.present? ||
                   github.present? ||
                   instagram.present? ||
                   linkedin.present? ||
                   website_url.present?
  end

  def is_hackroom_admin?(hackroom)
    own_hackrooms.include? hackroom
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
