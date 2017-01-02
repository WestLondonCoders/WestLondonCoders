class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_sign_in
    unless user_signed_in?
      redirect_to root_path
      flash[:alert] = 'You must be signed in to do that'
    end
  end
end
