class CreateAssignments < ActiveRecord::Migration[4.2]
  def change
    create_table :assignments do |t|
      t.references :user, null: false
      t.references :role, null: false
      t.timestamps null: false
    end
  end
end
