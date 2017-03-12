class PagesController < ApplicationController

  def home
    @posts = Post.all.where(featured: true).order("created_at desc")
    @comments = Comment.all.where(public: true).order("created_at desc")
    @sponsors = Sponsor.listed.order("name desc").take(4)
  end

  def learn
  end

end
