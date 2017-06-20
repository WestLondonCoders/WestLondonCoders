class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.references :author, references: :user, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
