class AddSponsorColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sponsor_id, :integer
  end
end
