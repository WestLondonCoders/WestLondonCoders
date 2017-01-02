class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :author
      t.date :publish_date
      t.string :tag
      t.timestamps
    end
  end
end
