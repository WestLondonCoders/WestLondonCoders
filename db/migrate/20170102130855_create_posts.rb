class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :tag
      t.timestamps
    end
  end
end
