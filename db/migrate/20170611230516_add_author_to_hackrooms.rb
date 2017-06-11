class AddAuthorToHackrooms < ActiveRecord::Migration[5.1]
  def change
    add_column :hackrooms, :author_id, :integer, references: :user
  end
end
