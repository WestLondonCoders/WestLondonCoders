class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :slug
      t.datetime :date, null: false

      t.timestamps null: false
    end
  end
end
