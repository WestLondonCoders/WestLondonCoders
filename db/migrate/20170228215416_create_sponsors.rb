class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name, null: false
      t.text :description
      t.string :logo
      t.text :address

      t.timestamps null: false
    end
  end
end
