class UsersController < ApplicationController
  before_action :get_user, except: [:index, :search, :organisers]
  skip_before_action :verify_authenticity_token, only: [:search]
  load_and_authorize_resource

  def show
    @posts = Post.all.where(created_by_id: @user).order("created_at asc")
    @comments = @user.comments.published.most_recent_first
  end

  def index
    @search = User.listed.ransack(params[:q])
    @users = @search.result.includes(:languages, :primary_languages).in_popularity_order
  end

  def search
    index
    render :index
  end

  def languages
    respond_to do |format|
      format.js
    end
  end

  def hackrooms
    respond_to do |format|
      format.js
    end
  end

  def posts
    respond_to do |format|
      format.js
    end
  end

  def meetups
    respond_to do |format|
      format.js
    end
  end

  def discussion
    @comments = @user.comments.published.most_recent_first
    respond_to do |format|
      format.js
    end
  end

  def organisers
    @organisers = User.organiser
  end

  def edit
    @languages = Language.all
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(user_params)
    else
      render :edit
    end
  end

  def follow
    @user_follow = UserFollow.find_or_create_by(follower_id: current_user.id, user_id: @user.id)
    @user.user_follows_count += 1
    create_follow_notification(@user)
    render :follows
  end

  def unfollow
    @user_follow = UserFollow.find_by(follower_id: current_user, user_id: @user)
    @user_follow.destroy if @user_follow
    @user.user_follows_count -= 1
    delete_follow_notification(@user)
    render :follows
  end

  private

  def get_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :listed, :bio, :image, :logo, :logo_link, :tagline, :twitter, :instagram, :github, :facebook, :linkedin, :permission, :website_url, :email, primary_language_ids: [], language_ids: [])
  end

  def create_follow_notification(user)
    Notification.create(user: user, notified_by: current_user, notifiable: user, action: 'followed')
  end

  def delete_follow_notification(user)
    notification = Notification.find_by(user_id: user.id, notified_by_id: current_user.id, notifiable_id: user.id, notifiable_type: 'User')
    notification.destroy if notification.present?
  end
end
