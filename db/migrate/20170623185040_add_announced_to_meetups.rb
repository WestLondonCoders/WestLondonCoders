class AddAnnouncedToMeetups < ActiveRecord::Migration[5.1]
  def change
    add_column :meetups, :announced, :boolean, default: false
  end
end
