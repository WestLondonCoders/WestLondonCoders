class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
end
