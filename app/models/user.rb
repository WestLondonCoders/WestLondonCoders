class User < ActiveRecord::Base
  has_many :user_interests
  has_many :interests, through: :user_interests
  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true

  has_many :user_skills
  has_many :skills, through: :user_skills
  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true

  has_many :comments, dependent: :destroy

  has_many :user_hackrooms
  has_many :hackrooms, through: :user_hackrooms

  has_many :user_languages
  has_many :languages, through: :user_languages

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
end
