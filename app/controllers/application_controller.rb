class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to users_path, notice: exception.message
  end

  if Rails.env.production?
    force_ssl
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ %r{/users}
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def require_sign_in
    unless user_signed_in?
      redirect_to user_github_omniauth_authorize_path
    end
  end

  def notify_all(triggered_by_user, subject, action)
    User.all.each do |user|
      Notification.create(user: user, notified_by: triggered_by_user, notifiable: subject, action: action)
    end
  end
end
