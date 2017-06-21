module CommentHelper
  def path_to_comment(comment)
    anchor = "comment-#{comment.id}"
    case
    when comment.commentable_type == 'Post'
      post_path(comment.commentable, anchor: anchor)
    when comment.commentable_type == 'Language'
      language_path(comment.commentable, anchor: anchor)
    when comment.commentable_type == 'Hackroom'
      hackroom_path(comment.commentable, anchor: anchor)
    when comment.commentable_type == 'Meetup'
      meetup_path(comment.commentable, anchor: anchor)
    when comment.commentable_type == 'Comment'
      post_path(comment.commentable.commentable, anchor: anchor)
    when comment.commentable_type == 'Course'
      course_path(comment.commentable, anchor: anchor)
    when comment.commentable_type == 'Step'
      course_step_path(comment.commentable.course, comment.commentable, anchor: anchor)
    end
  end

  def linked_reply_count(comment)
    pluralize(comment.comments.published.size, 'reply')
  end
end
