class RemoveEventSponsors < ActiveRecord::Migration[4.2]
  def change
    drop_table :event_sponsors
  end
end
