class PagesController < ApplicationController
  load_and_authorize_resource

  def home
    @posts = Post.all.where(featured: true).order("created_at desc")
    @comments = Comment.all.where(public: true).order("created_at desc")
    @sponsors = Sponsor.listed.order("name asc").take(6)
    @next_meetup = Meetup.in_upcoming_order.first
  end

  def learn
  end

end
