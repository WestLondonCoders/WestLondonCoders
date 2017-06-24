class AddImageToLanguages < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :image, :string
  end
end
