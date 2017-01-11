class AddDefaultValueToPostTwitterImage < ActiveRecord::Migration
  def up
    change_column :posts, :twitter_image, :string, default: "http://westlondoncoders.com/assets/general/twitter-81cac2affbb3e01cae4dce459fbf82a25f465cc53da98bf9d742afa3320ffe71.jpg"
  end

  def down
    change_column :posts, :twitter_image, :string
  end
end
