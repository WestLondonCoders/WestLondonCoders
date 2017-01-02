class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_sign_in
    unless user_signed_in?
      redirect_to root_path
      flash[:alert] = 'You must be signed in to do that'
    end
  end

  def require_admin
    unless current_user.admin == true
      redirect_to posts_path
      flash[:alert] = 'You must be an admin to do that'
    end
  end
end
