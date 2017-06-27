class RemoveNullConstraintOnLastName < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :last_name, :string, null: true
  end
end
