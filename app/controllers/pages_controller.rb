class PagesController < ApplicationController

  def home
    @page_title = "Home"
    @search = Post.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @posts = @search.result.includes(:created_by, :tags)
  end

  def learn
  end

end
