class PagesController < ApplicationController

  def home
    @page_title = "Home"
    @posts = Post.all
  end

  def learn
  end

end
