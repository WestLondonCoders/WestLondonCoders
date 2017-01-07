class CommentsController < ApplicationController
  before_action :find_commentable

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comments = @commentable.comments.order("created_at asc")
    @post = @commentable
    @comment = @commentable.comments.new comment_params
    @comment.author = current_user if current_user

    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @commentable
        end
        format.js # JavaScript response
      end
    end
  end

  def destroy
    @post = @commentable
    @comments = @commentable.comments.order("created_at asc")
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted.'
        redirect_to @commentable
      end
      format.js # JavaScript response
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end

  def find_commentable
    @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_slug(params[:post_id]) if params[:post_id]
  end
end
