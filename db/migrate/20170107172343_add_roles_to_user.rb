class AddRolesToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :editor, :boolean
    add_column :users, :moderator, :boolean
  end
end
