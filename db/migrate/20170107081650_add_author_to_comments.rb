class AddAuthorToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :author_id, :integer
  end
end
