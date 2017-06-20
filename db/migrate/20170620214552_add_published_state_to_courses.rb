class AddPublishedStateToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :published_at, :datetime
  end
end
