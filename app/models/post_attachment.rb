class PostAttachment < ActiveRecord::Base
  mount_uploader :avatar, PostAttachmentUploader
  belongs_to :post

  validates :avatar, file_size: { less_than: 5.megabytes }
end
