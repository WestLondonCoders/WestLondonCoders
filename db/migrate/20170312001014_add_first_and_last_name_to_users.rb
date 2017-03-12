class AddFirstAndLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, default: '', null: false
    add_column :users, :last_name, :string, default: '', null: false
  end
end
