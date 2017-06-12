class AddLinkToSponsor < ActiveRecord::Migration[4.2]
  def change
    add_column :sponsors, :link, :string
  end
end
