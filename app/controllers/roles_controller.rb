class RolesController < ApplicationController
  before_action :find_role, only: [:show, :edit, :update, :destroy]

  def new
    authorize! :create, Role
    @role = Role.new
  end

  def create
    authorize! :create, Role
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_roles_path, notice: 'Role created successfully.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize! :update, @role
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to admin_roles_path, notice: 'Role was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize! :destroy, @role
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_path, notice: 'Role deleted.' }
    end
  end

  private

  def find_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :description)
  end
end
