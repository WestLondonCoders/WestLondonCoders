class AddSocialLinksToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :github, :string
    add_column :users, :instagram, :string
    add_column :users, :website_url, :string
    add_column :users, :linkedin, :string
  end
end
