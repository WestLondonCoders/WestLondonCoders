class AddDefaultValueToPostDescription < ActiveRecord::Migration
  def up
    change_column :posts, :description, :string, default: "I wrote a post on West London Coders"
  end

  def down
    change_column :posts, :description, :string
  end
end
