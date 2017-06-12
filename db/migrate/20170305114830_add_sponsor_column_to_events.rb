class AddSponsorColumnToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :sponsor_id, :integer
  end
end
