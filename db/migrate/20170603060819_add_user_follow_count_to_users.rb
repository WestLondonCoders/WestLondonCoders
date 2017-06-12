class AddUserFollowCountToUsers < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :users, :user_follows_count, :integer, default: 0
  end
end
