class AddDefaultValueToPostDescription < ActiveRecord::Migration[4.2]
  def up
    change_column :posts, :description, :string, default: "I wrote a post on West London Coders"
  end

  def down
    change_column :posts, :description, :string
  end
end
