class AddRolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :editor, :boolean
    add_column :users, :moderator, :boolean
  end
end
