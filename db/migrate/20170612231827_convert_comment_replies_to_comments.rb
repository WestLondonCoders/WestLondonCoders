class ConvertCommentRepliesToComments < ActiveRecord::Migration[5.1]
  def change
    CommentReply.all.each do |cr|
      cr.comment.comments.create(body: cr.body, author: cr.author, created_at: cr.created_at)
    end
  end
end
