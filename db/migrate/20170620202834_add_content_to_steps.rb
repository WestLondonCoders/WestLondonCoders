class AddContentToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :content, :text
  end
end
