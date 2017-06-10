class RenameEventToMeetup < ActiveRecord::Migration
  def up
    rename_table :events, :meetups
  end

  def down
    rename_table :meetups, :events
  end
end
