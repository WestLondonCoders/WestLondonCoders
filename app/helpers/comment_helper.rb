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
    else
      nil
    end

  end
end
