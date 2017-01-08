class PagesController < ApplicationController

  def home
    @page_title = "Home"
    @posts = Post.all.where(featured: true).order("created_at desc")
  end

  def learn
  end

end
