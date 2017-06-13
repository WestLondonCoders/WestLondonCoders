class LikesController < ApplicationController
  before_action :find_like

  def create
    @like = @likeable.likes.find_or_create_by(user: current_user)
    notify_likeable_author unless @likeable.author == current_user
    render :create
  end

  def destroy
    @like.destroy
    remove_likeable_author_notification unless @likeable.author == current_user
    render :destroy
  end

  private

  def find_like
    case
    when params[:id]
      @like = Like.find(params[:id])
      @likeable = @like.likeable
    when params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    else
      nil
    end
  end

  def notify_likeable_author
    Notification.create(user: @likeable.author, notified_by: current_user, notifiable: @likeable, action: 'liked')
  end

  def remove_likeable_author_notification
    Notification.where(user: current_user, likeable: @likeable).destroy_all
  end
end
