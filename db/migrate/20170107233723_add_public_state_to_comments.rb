class AddPublicStateToComments < ActiveRecord::Migration[4.2]
  def change
    add_column :comments, :public, :boolean, default: true
  end
end
