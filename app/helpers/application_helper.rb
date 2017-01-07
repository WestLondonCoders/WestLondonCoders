module ApplicationHelper

  def set_page_title(title)
    @page_title = title + " | West London Coders"
  end

  def user_is_admin?
    current_user && current_user.admin
  end

  def admin_or_current_user?
    user_is_admin? || @user == current_user
  end

  def user_is_editor?
    current_user && current_user.editor
  end

  def user_is_moderator?
    current_user && current_user.moderator
  end

  def avatar_url(user)
    default_url = "http://stevebrewer.uk/img/avatar.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI.escape(default_url)}"
  end
end
