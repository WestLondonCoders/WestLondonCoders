class RemoveSkills < ActiveRecord::Migration
  def change
    drop_table :skills
    drop_table :user_skills
  end
end
