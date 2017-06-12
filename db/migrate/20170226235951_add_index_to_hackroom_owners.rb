class AddIndexToHackroomOwners < ActiveRecord::Migration[4.2]
  def change
    add_index :hackroom_owners, [:hackroom_id, :user_id], unique: true
  end
end
