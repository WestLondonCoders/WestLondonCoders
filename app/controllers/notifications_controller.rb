class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order('created_at desc')
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to @notification.notifiable
  end

  def mark_all_read
    current_user.notifications.unread.each do |n|
      n.update read: true
    end
  end
end
