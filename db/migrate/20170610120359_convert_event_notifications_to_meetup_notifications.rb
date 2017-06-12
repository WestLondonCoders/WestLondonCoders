class ConvertEventNotificationsToMeetupNotifications < ActiveRecord::Migration[4.2]
  def change
    Notification.where(notifiable_type: 'Event').each do |n|
      n.update(notifiable_type: 'Meetup')
    end
  end
end
