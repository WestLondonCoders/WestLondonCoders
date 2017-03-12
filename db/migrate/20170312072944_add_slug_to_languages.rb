class AddSlugToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :slug, :string, default: ''
  end
end
