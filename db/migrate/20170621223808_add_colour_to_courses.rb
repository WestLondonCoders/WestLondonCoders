class AddColourToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :colour, :string, default: '#000000', null: false
  end
end
