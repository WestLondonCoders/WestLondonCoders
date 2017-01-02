class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order("created_at desc")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Zombie was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Zombie was successfully updated.' }
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
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :author, :publish_date)
  end

end
