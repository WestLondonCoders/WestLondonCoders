class Admin::RolesController < Admin::BaseController
  before_action :get_role, only: [:update]
  load_and_authorize_resource

  layout 'admin'

  def index
    @roles = Role.all
  end

  def update
    if @role.update(role_params)
      redirect_to admin_roles_path
      UserMailer.welcome_email(User.first).deliver_now
    else
      render :edit
    end
  end

  private

  def get_role
    @user = Role.find(params[:id])
  end

  def role_params
    params[:user].permit(:name)
  end
end
