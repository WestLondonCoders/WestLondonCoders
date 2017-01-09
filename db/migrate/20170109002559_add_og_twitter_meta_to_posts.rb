class AddOgTwitterMetaToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :string
    add_column :posts, :twitter_image, :string
  end
end
