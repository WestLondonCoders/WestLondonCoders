class CreateStepCompletions < ActiveRecord::Migration[5.1]
  def change
    create_table :step_completions do |t|
      t.references :user, null: false
      t.references :step, null: false

      t.timestamps null: false
    end
  end
end
