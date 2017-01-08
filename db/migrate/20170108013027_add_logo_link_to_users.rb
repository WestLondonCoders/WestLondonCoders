class AddLogoLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logo_link, :string
  end
end
