class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_sign_in
    unless user_signed_in?
      redirect_to new_session_path(:user)
      flash[:alert] = 'You must be signed in to do that'
    end
  end

  def require_admin
    unless is_admin(current_user)
      redirect_to posts_path
      flash[:alert] = 'You must be an admin to do that'
    end
  end

  def require_admin
    unless is_admin(current_user)
      redirect_to :back
      flash[:alert] = "You're not authorised to do that"
    end
  end

# User permissions
  def this_user_or_admin(user)
    current_user || user.permission >= 50 if current_user
  end

  def is_moderator(user)
    user.permission >= 20 if current_user
  end

  def is_author(user)
    user.permission >= 30 if current_user
  end

  def is_editor(user)
    user.permission >= 40 if current_user
  end

  def is_admin(user)
    user.permission >= 50 if current_user
  end
end
