class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user, null: false
      t.references :role, null: false
      t.timestamps null: false
    end
  end
end
