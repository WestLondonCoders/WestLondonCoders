class Sponsor < ActiveRecord::Base
  has_many :events

  has_many :sponsorship_admins
  has_many :users, through: :sponsorship_admins

  mount_uploader :logo, LogoUploader
end
