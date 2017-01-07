class AddPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permission, :integer
    remove_column :users, :admin
    remove_column :users, :moderator
    remove_column :users, :editor
  end
end
