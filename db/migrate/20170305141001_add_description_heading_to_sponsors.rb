class AddDescriptionHeadingToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :description_heading, :string
  end
end
