class AddAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_by_id, :integer
  end
end
