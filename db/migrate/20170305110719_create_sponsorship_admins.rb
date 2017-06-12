class CreateSponsorshipAdmins < ActiveRecord::Migration[4.2]
  def change
    create_table :sponsorship_admins do |t|
      t.references :user, null: false
      t.references :sponsor, null: false

      t.timestamps null: false
    end
  end
end
