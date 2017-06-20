class CreateCourseSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :title, null: false
      t.integer :position, null: false
      t.references :course, null: false

      t.timestamps null: false
    end
  end
end
