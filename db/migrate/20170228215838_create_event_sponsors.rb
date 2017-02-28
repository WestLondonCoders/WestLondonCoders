class CreateEventSponsors < ActiveRecord::Migration
  def change
    create_table :event_sponsors do |t|
      t.references :event, null: false
      t.references :sponsor, null: false

      t.timestamps null: false
    end

    add_index :event_sponsors, [:event_id, :sponsor_id], unique: true
    add_index :event_sponsors, :event_id
    add_foreign_key :event_sponsors, :sponsors, on_delete: :cascade
    add_foreign_key :event_sponsors, :events, on_delete: :cascade
  end
end
