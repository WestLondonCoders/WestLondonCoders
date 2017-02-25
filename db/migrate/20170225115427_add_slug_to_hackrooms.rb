class AddSlugToHackrooms < ActiveRecord::Migration
  def change
    add_column :hackrooms, :slug, :string
    add_index :hackrooms, :slug, unique: true
  end
end
