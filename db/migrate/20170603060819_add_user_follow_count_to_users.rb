class AddUserFollowCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_follows_count, :integer, default: 0
  end
end
