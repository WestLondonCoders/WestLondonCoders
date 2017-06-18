class PostAttachment < ActiveRecord::Base
  belongs_to :post

  validates :avatar, file_size: { less_than: 5.megabytes }
end
