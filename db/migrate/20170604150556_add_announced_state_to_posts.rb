class AddAnnouncedStateToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :announced, :boolean, default: false
  end
end
