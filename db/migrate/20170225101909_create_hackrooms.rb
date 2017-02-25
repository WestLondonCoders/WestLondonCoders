class CreateHackrooms < ActiveRecord::Migration
  def change
    create_table :hackrooms do |t|
      t.string :name, null: false
      t.text :mission
      t.string :slack
      t.string :url

      t.timestamps null: false
    end
  end
end
