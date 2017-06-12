class AddCompanyLogoToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :logo, :string
  end
end
