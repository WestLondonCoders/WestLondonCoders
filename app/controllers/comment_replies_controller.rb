class CommentRepliesController < ApplicationController
  before_action :find_comment
  before_action :find_reply, only: [:destroy, :hide]

  def new
    @reply = CommentReply.new
  end

  def create
    @reply = @comment.replies.new comment_params
    @reply.author = current_user if current_user

    if @reply.save
      respond_to do |format|
        format.html do
          redirect_to @comment.commentable, anchor: "comment-#{@comment.id}"
        end
        format.js
      end
    end
  end

  def destroy
    @reply.destroy

    respond_to do |format|
      format.html do
        redirect_to @commentable
      end
      format.js
    end
  end

  def hide
    @reply.update(public: false)

    if @reply.save
      render :create
    end
  end

  private

  def comment_params
    params.require(:comment_reply).permit(:body, :author_id, :public)
  end

  def find_reply
    @reply = CommentReply.find(params[:id])
  end

  def find_comment
    @comment = Comment.find(params[:comment_id])
    @post = @comment.commentable
  end
end
