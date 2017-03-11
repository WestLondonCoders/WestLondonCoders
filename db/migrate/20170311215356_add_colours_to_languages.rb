class AddColoursToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :colour, :string, default: '#000000', null: false
  end
end
