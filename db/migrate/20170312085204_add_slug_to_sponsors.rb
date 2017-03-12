class AddSlugToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :slug, :string, default: ''
  end
end
