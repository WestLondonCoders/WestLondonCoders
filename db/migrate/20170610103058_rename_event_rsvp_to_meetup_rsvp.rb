class RenameEventRsvpToMeetupRsvp < ActiveRecord::Migration[4.2]
  def up
    rename_table :event_rsvps, :meetup_rsvps
  end

  def down
    rename_table :meetup_rsvps, :event_rsvps
  end
end
