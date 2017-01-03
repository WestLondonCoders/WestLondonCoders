class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]
  before_action :require_sign_in, only: [:index]

  def show
  end

  def index
    @search = User.ransack(params[:q])
    @search.sorts = 'last_active_at asc' if @search.sorts.empty?
    @users = @search.result
  end

  def search
    index
    render :index
  end


  def edit
    if admin_or_current_user?
      render :edit
    else
      redirect_to user_path(user_params[:id])
    end
  end

  def update
    if admin_or_current_user?
      if @user.update(user_params)
        redirect_to user_path(user_params)
        flash[:alert] = 'Profile updated'
      else
        flash[:alert] = 'Something went wrong updating your profile'
        render :edit
      end
    else
      redirect_to user_path(user_params)
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :bio, :image, :job_title, :twitter, :instagram, :github, :facebook, :linkedin, :website_url)
  end
end
