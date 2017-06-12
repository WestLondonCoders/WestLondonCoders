class AddOgTwitterMetaToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :description, :string
    add_column :posts, :twitter_image, :string
  end
end
