class Admin::UsersController < Admin::BaseController
  before_action :get_user, only: [:update]

  layout 'admin'

  def index
    authorize! :manage, @users
    @search = User.ransack(params[:q])
    @search.sorts = 'last_sign_in_at desc' if @search.sorts.empty?
    @users = @search.result.includes(:roles, :hackrooms, :own_hackrooms)
    @roles = Role.all
  end

  def search
    index
    render :index
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path }
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :bio, :image, :logo, :logo_link, :tagline, :twitter, :instagram, :github, :facebook, :linkedin, :permission, :website_url, role_ids: [], primary_language_ids: [], language_ids: [])
  end
end
