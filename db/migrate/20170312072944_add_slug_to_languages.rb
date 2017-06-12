class AddSlugToLanguages < ActiveRecord::Migration[4.2]
  def change
    add_column :languages, :slug, :string, default: ''
  end
end
