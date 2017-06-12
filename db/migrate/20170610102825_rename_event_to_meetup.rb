class RenameEventToMeetup < ActiveRecord::Migration[4.2]
  def up
    rename_table :events, :meetups
  end

  def down
    rename_table :meetups, :events
  end
end
