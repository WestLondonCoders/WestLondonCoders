class Sponsor < ActiveRecord::Base
  has_many :events

  mount_uploader :logo, LogoUploader
end
