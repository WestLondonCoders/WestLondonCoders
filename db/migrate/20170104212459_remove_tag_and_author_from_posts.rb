class RemoveTagAndAuthorFromPosts < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :tag
    remove_column :posts, :author
  end
end
