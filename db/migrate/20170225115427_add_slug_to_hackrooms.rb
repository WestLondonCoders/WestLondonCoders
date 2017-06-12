class AddSlugToHackrooms < ActiveRecord::Migration[4.2]
  def change
    add_column :hackrooms, :slug, :string
    add_index :hackrooms, :slug, unique: true
  end
end
