class AddLogoLinkToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :logo_link, :string
  end
end
