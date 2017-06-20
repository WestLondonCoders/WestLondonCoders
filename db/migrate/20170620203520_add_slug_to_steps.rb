class AddSlugToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :slug, :string
  end
end
