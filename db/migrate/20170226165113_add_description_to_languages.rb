class AddDescriptionToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :description, :text
  end
end
