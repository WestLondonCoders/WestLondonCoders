class DropSponsorsTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :sponsors
    drop_table :sponsorship_admins
    drop_table :sponsor_languages
  end
end
