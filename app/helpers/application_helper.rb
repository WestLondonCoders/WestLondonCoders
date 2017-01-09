module ApplicationHelper

  def set_page_title(title)
    @page_title = title + " | West London Coders"
  end

  def set_page_description(description)
    @page_description = description || "Dive into web development with relaxed and friendly developers at the stunning NET-A-PORTER HQ in Westfield, White City."
  end

  def set_page_image(image)
    @page_image = image || "http://westlondoncoders.com/img/general/twitter.jpg"
  end

  def page_twitter(twitter)
    @page_twitter = twitter || @user.twitter || @post.created_by.twitter || "@westlondoncode"
  end

  def avatar_url(user)
    default_url = "http://stevebrewer.uk/img/avatar.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=150&d=#{CGI.escape(default_url)}"
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
