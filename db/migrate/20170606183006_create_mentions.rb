class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.references :mentionee, polymorphic: true
      t.references :mentioner, polymorphic: true

      t.timestamps null: false
    end

    add_index :mentions, [:mentionee_id, :mentionee_type], name: "mentions_mentionee_idx"
    add_index :mentions, [:mentioner_id, :mentioner_type], name: "mentions_mentioner_idx"
    add_index :mentions, [:mentionee_id, :mentionee_type, :mentioner_id, :mentioner_type], name: "mentions_mentionee_mentioner_idx", unique: true
  end
end

