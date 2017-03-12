class Sponsor < ActiveRecord::Base
  has_many :events, counter_cache: true

  has_many :sponsorship_admins
  has_many :users, through: :sponsorship_admins

  mount_uploader :logo, LogoUploader

  validates :link, presence: true

  scope :listed, -> { where(listed: true) }
end
