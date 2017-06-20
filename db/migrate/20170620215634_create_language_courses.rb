class CreateLanguageCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :language_courses do |t|
      t.references :language, null: false
      t.references :course, null: false

      t.timestamps null: false
    end
  end
end
