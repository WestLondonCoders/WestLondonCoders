class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :edit_interests]

  def show
    @posts = Post.all.where(created_by_id: @user).order("created_at desc")
  end

  def index
    @search = User.listed.ransack(params[:q])
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @users = @search.result.includes(:languages, :hackrooms)
  end

  def search
    index
    render :index
  end

  def organisers
    @organisers = User.organiser
  end

  def edit
    authorize! :edit, @user
    @languages = Language.all
  end

  def edit_interests
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

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :listed, :bio, :image, :logo, :logo_link, :tagline, :twitter, :instagram, :github, :facebook, :linkedin, :permission, :website_url, :email, primary_language_ids: [], language_ids: [], interests_attributes: [:id, :name, :_destroy])
  end

  def require_admin_or_owner
    unless user_is_owner_or_admin
      redirect_to user_path(@user)
      flash[:alert] = "You're not authorised to do that"
    end
  end
end
