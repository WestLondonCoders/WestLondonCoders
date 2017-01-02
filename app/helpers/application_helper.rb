module ApplicationHelper

  def set_page_title(title)
    @page_title = title + " | West London Coders"
  end

  def user_is_admin?
    current_user && current_user.admin
  end

end
