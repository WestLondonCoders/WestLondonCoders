class AddListedStateToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :listed, :boolean, default: false, null: false
  end
end
