class CreateEventRsvps < ActiveRecord::Migration[4.2]
  def change
    create_table :event_rsvps do |t|
      t.references :user, null: false
      t.references :event, null: false

      t.timestamps null: false
    end

    add_index :event_rsvps, [:user_id, :event_id], unique: true
    add_index :event_rsvps, :user_id
    add_foreign_key :event_rsvps, :users, on_delete: :cascade
    add_foreign_key :event_rsvps, :events, on_delete: :cascade
  end
end
