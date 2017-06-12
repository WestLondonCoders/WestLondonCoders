class RenameEventColumnOnMeetupRsvps < ActiveRecord::Migration[4.2]
  def up
    rename_column :meetup_rsvps, :event_id, :meetup_id
  end

  def down
    rename_column :meetup_rsvps, :meetup_id, :event_id
  end
end
