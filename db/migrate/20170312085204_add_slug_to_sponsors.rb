class AddSlugToSponsors < ActiveRecord::Migration[4.2]
  def change
    add_column :sponsors, :slug, :string, default: ''
  end
end
