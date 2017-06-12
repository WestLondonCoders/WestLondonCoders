class CreateHackroomOwners < ActiveRecord::Migration[4.2]
  def change
    create_table :hackroom_owners do |t|
      t.references :user, null: false
      t.references :hackroom, null: false
      t.timestamps null: false
    end
  end
end
