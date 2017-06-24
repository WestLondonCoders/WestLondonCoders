class PagesController < ApplicationController
  def home
    @posts = Post.all.where(featured: true).order("created_at desc")
    @comments = Comment.top_level.published.most_recent_first.take(6)
    @sponsors = Sponsor.listed.order("name asc").take(6)
    @next_meetup = Meetup.in_upcoming_order.first
  end
end
