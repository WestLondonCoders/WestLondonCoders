class RemoveManagerFromSponsors < ActiveRecord::Migration
  def change
    remove_index :sponsors, :manager_id
  end
end
