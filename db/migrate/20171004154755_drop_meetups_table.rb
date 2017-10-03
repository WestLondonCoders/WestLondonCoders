class DropMeetupsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :meetup_rsvps
    drop_table :meetups
  end
end
