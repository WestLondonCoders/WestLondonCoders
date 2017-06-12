class AddUniqueIndexToUserHackrooms < ActiveRecord::Migration[4.2]
  def change
    add_index :user_hackrooms, [:user_id, :hackroom_id], unique: true
  end
end
