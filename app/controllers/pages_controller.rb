class PagesController < ApplicationController

  def home
    @page_title = "Home"
    @user = User.all.where(editor: true)
    @posts = Post.all.where(created_by_id: @user).order("created_at desc")
  end

  def learn
  end

end
