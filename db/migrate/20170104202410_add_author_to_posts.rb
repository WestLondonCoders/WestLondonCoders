class AddAuthorToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :created_by_id, :integer
  end
end
