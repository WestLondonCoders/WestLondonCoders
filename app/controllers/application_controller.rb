class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_filter :store_location

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def require_sign_in
    unless user_signed_in?
      redirect_to user_github_omniauth_authorize_path
    end
  end

  def require_admin
    unless user_is_admin
      redirect_to root_path
      flash[:alert] = "You're not authorised to do that"
    end
  end

# User permissions
  def user_is_owner_or_admin
    current_user == @user || current_user.permission >= 50 if current_user
  end

  def user_is_moderator
    current_user.permission >= 20 if current_user
  end

  def user_is_author
    current_user.permission >= 30 if current_user
  end

  def user_is_editor
    current_user.permission >= 40 if current_user
  end

  def user_is_admin
    current_user.permission >= 50 if current_user
  end
end
