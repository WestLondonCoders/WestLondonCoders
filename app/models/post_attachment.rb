class PostAttachment < ActiveRecord::Base
  belongs_to :post

  mount_uploader :avatar, PostAttachmentUploader

  validates :avatar, file_size: { less_than: 5.megabytes }
end
