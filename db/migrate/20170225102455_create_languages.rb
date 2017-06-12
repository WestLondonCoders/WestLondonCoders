class CreateLanguages < ActiveRecord::Migration[4.2]
  def change
    create_table :languages do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
