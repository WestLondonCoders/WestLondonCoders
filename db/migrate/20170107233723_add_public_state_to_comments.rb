class AddPublicStateToComments < ActiveRecord::Migration
  def change
    add_column :comments, :public, :boolean, default: true
  end
end
