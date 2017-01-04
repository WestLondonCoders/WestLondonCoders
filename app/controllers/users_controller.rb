class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :edit_interests, :edit_skills]

  def show
  end

  def index
    @search = User.ransack(params[:q])
    @search.sorts = 'last_active_at asc' if @search.sorts.empty?
    @users = @search.result.includes(:interests, :skills)
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

  def edit_interests
    if admin_or_current_user?
      render :edit_interests
    else
      redirect_to user_path(user_params[:id])
    end
  end

  def edit_skills
    if admin_or_current_user?
      render :edit_skills
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
    @user = User.find_by_slug(params[:id])
  end

  def user_params
    params[:user].permit(:name, :bio, :image, :job_title, :twitter, :instagram, :github, :facebook, :linkedin, :website_url, interests_attributes: [:id, :name, :_destroy], skills_attributes: [:id, :name, :_destroy])
  end
end
