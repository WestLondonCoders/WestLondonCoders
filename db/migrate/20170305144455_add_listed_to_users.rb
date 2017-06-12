class AddListedToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :listed, :boolean, default: true
  end
end
