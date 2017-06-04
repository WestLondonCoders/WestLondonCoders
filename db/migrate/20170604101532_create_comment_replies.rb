class CreateCommentReplies < ActiveRecord::Migration
  def change
    create_table :comment_replies do |t|
      t.text :body, null: false
      t.references :comment, null: false
      t.references :author, references: :users, null: false
      t.boolean :public, null: false, default: true

      t.timestamps null: false
    end
  end
end
