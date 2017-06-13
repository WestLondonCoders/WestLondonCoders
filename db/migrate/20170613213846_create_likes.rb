class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, index: true
      t.integer :likeable_id, index: true
      t.string :likeable_type

      t.timestamps null: false
    end
    add_foreign_key :likes, :users
  end
end
