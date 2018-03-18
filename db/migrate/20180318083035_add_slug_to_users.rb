class AddSlugToUsers < ActiveRecord::Migration[5.1]
  def change
    if Rails.env.development?
      add_column :users, :slug, :string
    end
  end
end
