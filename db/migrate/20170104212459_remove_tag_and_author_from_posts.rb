class RemoveTagAndAuthorFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :tag
    remove_column :posts, :author
  end
end
