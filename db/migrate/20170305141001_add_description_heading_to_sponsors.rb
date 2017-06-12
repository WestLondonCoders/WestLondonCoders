class AddDescriptionHeadingToSponsors < ActiveRecord::Migration[4.2]
  def change
    add_column :sponsors, :description_heading, :string
  end
end
