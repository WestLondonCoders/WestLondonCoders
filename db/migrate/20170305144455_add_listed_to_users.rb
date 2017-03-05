class AddListedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :listed, :boolean, default: true
  end
end
