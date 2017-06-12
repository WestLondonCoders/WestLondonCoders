class CreateSponsorLanguages < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :sponsor_languages do |t|
      t.references :sponsor, null: false
      t.references :language, null: false
      t.timestamps null: false
    end
  end
end
