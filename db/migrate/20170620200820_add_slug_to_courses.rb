class AddSlugToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :slug, :string
  end
end
