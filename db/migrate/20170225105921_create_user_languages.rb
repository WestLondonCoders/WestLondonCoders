class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.references :user, null: false
      t.references :language, null: false
      t.timestamps null: false
    end
  end
end
