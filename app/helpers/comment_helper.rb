module CommentHelper
  def path_to_comment(comment)
    case
    when comment.commentable_type == 'Post'
      post_path(comment.commentable, anchor: "comment-#{comment.id}")
    when comment.commentable_type == 'Language'
      language_path(comment.commentable, anchor: "comment-#{comment.id}")
    when comment.commentable_type == 'Hackroom'
      hackroom_path(comment.commentable, anchor: "comment-#{comment.id}")
    when comment.commentable_type == 'Meetup'
      meetup_path(comment.commentable, anchor: "comment-#{comment.id}")
    when comment.commentable_type == 'Comment'
      post_path(comment.commentable.commentable, anchor: "comment-#{comment.id}")
    end
  end

  def linked_reply_count(comment)
    pluralize(comment.comments.published.size, 'reply')
  end
end
