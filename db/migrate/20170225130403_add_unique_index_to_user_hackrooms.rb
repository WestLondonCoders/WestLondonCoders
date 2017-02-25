class AddUniqueIndexToUserHackrooms < ActiveRecord::Migration
  def change
    add_index :user_hackrooms, [:user_id, :hackroom_id], unique: true
  end
end
