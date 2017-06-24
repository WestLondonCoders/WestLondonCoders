module CommentHelper
  def linked_reply_count(comment)
    pluralize(comment.comments.published.size, 'reply')
  end
end
