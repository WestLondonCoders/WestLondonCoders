class Sponsor < ActiveRecord::Base
  has_many :meetups, counter_cache: true
  has_many :sponsorship_admins
  has_many :users, through: :sponsorship_admins
  has_many :sponsor_languages
  has_many :languages, through: :sponsor_languages

  mount_uploader :logo, LogoUploader

  validates :link, presence: true

  scope :listed, -> { where(listed: true) }

  extend FriendlyId
  friendly_id :slug, use: :slugged
end
