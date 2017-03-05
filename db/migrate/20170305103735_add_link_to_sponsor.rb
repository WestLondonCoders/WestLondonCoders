class AddLinkToSponsor < ActiveRecord::Migration
  def change
    add_column :sponsors, :link, :string
  end
end
