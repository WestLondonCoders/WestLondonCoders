class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }

  def about_new_follow?
    notifiable_type == 'User' && action == 'followed'
  end

  def about_comment_on_your_post?
    notifiable_type == 'Post'
  end

  def about_reply_to_your_comment?
    notifiable_type == 'Comment'
  end

  def about_new_meetup?
    notifiable_type == 'Event'
  end

  def about_mention_in_comment?
    action = 'mentioned you' && notifiable_type == 'Comment'
  end
end
