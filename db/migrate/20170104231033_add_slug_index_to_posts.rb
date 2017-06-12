class AddSlugIndexToPosts < ActiveRecord::Migration[4.2]
  def change
    add_index :posts, :slug
  end
end
