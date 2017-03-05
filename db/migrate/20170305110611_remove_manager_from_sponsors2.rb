class RemoveManagerFromSponsors2 < ActiveRecord::Migration
  def change
    remove_column :sponsors, :manager_id
  end
end
