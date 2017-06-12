class CreateOrganiserInterests < ActiveRecord::Migration[4.2]
  def change
    create_table :organiser_interests do |t|
      t.references :user, null: false, unique: true

      t.timestamps null: false
    end
    add_index :organiser_interests, :user_id, unique: true
  end
end
