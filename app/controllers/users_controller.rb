class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    get_user
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

end
