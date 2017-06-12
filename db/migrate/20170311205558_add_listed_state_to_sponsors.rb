class AddListedStateToSponsors < ActiveRecord::Migration[4.2]
  def change
    add_column :sponsors, :listed, :boolean, default: false, null: false
  end
end
