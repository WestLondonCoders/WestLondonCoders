class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :edit_interests, :edit_skills]

  def show
    @posts = Post.all.where(created_by_id: @user).order("created_at desc")
  end

  def index
    @search = User.ransack(params[:q])
    @search.sorts = 'last_sign_in_at desc' if @search.sorts.empty?
    @users = @search.result.includes(:interests, :skills)
  end

  def search
    index
    render :index
  end

  def edit
    authorize! :edit, @user
    @languages = Language.all
  end

  def edit_interests
    authorize! :edit, @user
  end

  def edit_skills
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to user_path(user_params)
    else
      render :edit
    end
  end

  def admin
    authorize! :manage, @users
    @users = User.all
    @roles = Role.all
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :bio, :image, :logo, :logo_link, :tagline, :twitter,
                         :instagram, :github, :facebook, :linkedin, :permission,
                         :website_url, role_ids: [], primary_language_ids: [],
                         language_ids: [], interests_attributes: [:id, :name, :_destroy],
                         skills_attributes: [:id, :name, :_destroy])
  end

  def require_admin_or_owner
    unless user_is_owner_or_admin
      redirect_to user_path(@user)
      flash[:alert] = "You're not authorised to do that"
    end
  end
end
