class CreatePostAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :post_attachments do |t|
      t.integer :post_id
      t.string :avatar

      t.timestamps null: false
    end
  end
end
