class CreateHackroomOwners < ActiveRecord::Migration
  def change
    create_table :hackroom_owners do |t|
      t.references :user, null: false
      t.references :hackroom, null: false
      t.timestamps null: false
    end
  end
end
