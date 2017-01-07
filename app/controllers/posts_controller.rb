class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :destroy]
  before_action :require_sign_in, only: [:new, :update]

  def index
    @search = Post.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @posts = @search.result.includes(:created_by, :tags)
  end

  def search
    index
    render :index
  end

  def show
    @tag = Tag.find_by(id: tag_params[:id])
    @comments = @post.comments.order("created_at asc")
    @new_comment = @post.comments.new
  end

  def new_comment
    show
    render :show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.created_by = current_user
    @post.slug = @post.title.downcase.gsub(" ", "-")

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post deleted' }
    end
  end

  private

  def get_post
    @post = Post.find_by_slug(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :slug, tags_attributes: [:id, :name, :_destroy] )
  end

  def tag_params
    params.permit(:id)
  end

end
