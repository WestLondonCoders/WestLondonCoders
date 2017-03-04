class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to users_path, alert: exception.message
  end

  protect_from_forgery with: :exception
  after_filter :store_location

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ %r{/\/users/}
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
end
