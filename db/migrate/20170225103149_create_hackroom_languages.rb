class CreateHackroomLanguages < ActiveRecord::Migration
  def change
    create_table :hackroom_languages do |t|
      t.references :hackroom, null: false
      t.references :language, null: false
      t.timestamps null: false
    end
  end
end
