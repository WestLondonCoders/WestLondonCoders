class DropRoles < ActiveRecord::Migration[5.1]
  def change
    drop_table :assignments
    drop_table :roles
  end
end
