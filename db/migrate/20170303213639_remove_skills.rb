class RemoveSkills < ActiveRecord::Migration[4.2]
  def change
    drop_table :skills
    drop_table :user_skills
  end
end
