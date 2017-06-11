class AddAuthorToLanguages < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :author_id, :integer, references: :user
  end
end
