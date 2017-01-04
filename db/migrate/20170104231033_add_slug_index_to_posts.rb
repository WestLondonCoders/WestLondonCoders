class AddSlugIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :slug
  end
end
