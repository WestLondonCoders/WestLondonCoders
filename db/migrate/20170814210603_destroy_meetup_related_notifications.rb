class DestroyMeetupRelatedNotifications < ActiveRecord::Migration[5.1]
  def change
    Notification.where(notifiable_type: 'Meetup').destroy_all
  end
end
