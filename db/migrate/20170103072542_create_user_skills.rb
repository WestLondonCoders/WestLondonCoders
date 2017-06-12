class CreateUserSkills < ActiveRecord::Migration[4.2]
  def change
    create_table :user_skills do |t|
      t.integer :user_id, :skill_id
      t.timestamps
    end
  end
end
