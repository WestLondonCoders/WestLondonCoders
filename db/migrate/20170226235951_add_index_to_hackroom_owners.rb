class AddIndexToHackroomOwners < ActiveRecord::Migration
  def change
    add_index :hackroom_owners, [:hackroom_id, :user_id], unique: true
  end
end
