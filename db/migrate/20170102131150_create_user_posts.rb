class CreateUserPosts < ActiveRecord::Migration
  def change
    create_table :user_posts do |t|
      t.integer :user_id, :post_id
      t.timestamps
    end
  end
end
