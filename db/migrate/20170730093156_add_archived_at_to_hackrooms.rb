class AddArchivedAtToHackrooms < ActiveRecord::Migration[5.1]
  def change
    add_column :hackrooms, :archived_at, :datetime
  end
end
