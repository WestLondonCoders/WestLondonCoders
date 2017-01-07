module ApplicationHelper

  def set_page_title(title)
    @page_title = title + " | West London Coders"
  end

  def avatar_url(user)
    default_url = "http://stevebrewer.uk/img/avatar.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI.escape(default_url)}"
  end

# User permissions
  def this_user_or_admin(user)
    current_user || user.permission >= 50
  end

  def is_moderator(user)
    user.permission >= 20
  end

  def is_author(user)
    user.permission >= 30
  end

  def is_editor(user)
    user.permission >= 40
  end

  def is_admin(user)
    user.permission >= 50
  end
end
