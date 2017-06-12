class AddColoursToLanguages < ActiveRecord::Migration[4.2]
  def change
    add_column :languages, :colour, :string, default: '#000000', null: false
  end
end
