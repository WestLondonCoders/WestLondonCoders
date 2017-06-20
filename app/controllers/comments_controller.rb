class CommentsController < ApplicationController
  before_action :find_commentable
  load_and_authorize_resource

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.author = current_user
    if @comment.save
      send_notifications
      @commentable = @comment.commentable.commentable if @comment.commentable_type == 'Comment'
      respond_to do |format|
        format.html do
          redirect_to @commentable, anchor: "comment-#{@comment.id}"
        end
        format.js
      end
    end
  end

  def hide
    find_comment
    @commentable = @comment.commentable

    @comment.update(public: false)

    if @comment.save
      @commentable = @comment.commentable.commentable if @comment.commentable_type == 'Comment'
      render :update
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    case
    when params[:post_id]
      @commentable = Post.find_by_slug(params[:post_id])
    when params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    when params[:language_id]
      @commentable = Language.find_by_slug(params[:language_id])
    when params[:hackroom_id]
      @commentable = Hackroom.find_by_slug(params[:hackroom_id])
    when params[:meetup_id]
      @commentable = Meetup.find_by_slug(params[:meetup_id])
    when params[:step_id]
      @commentable = Step.friendly.find(params[:step_id])
    when params[:course_id]
      @commentable = Course.friendly.find(params[:course_id])
    else
      nil
    end
  end

  def send_notifications
    if @comment.commentable_type == 'Hackroom'
      @comment.commentable.all_members.map { |member| Notification.create(user: member, notified_by: current_user, notifiable: @commentable, action: 'commented on the') unless @commentable.author == current_user }
    else
      Notification.create(user: @commentable.author, notified_by: current_user, notifiable: @commentable, action: 'commented on your') unless @commentable.author == current_user
    end
  end
end
