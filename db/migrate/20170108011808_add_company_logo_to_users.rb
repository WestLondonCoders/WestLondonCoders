class AddCompanyLogoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logo, :string
  end
end
