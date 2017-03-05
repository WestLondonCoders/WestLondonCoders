class RemoveEventSponsors < ActiveRecord::Migration
  def change
    drop_table :event_sponsors
  end
end
