class AddAnnouncedStateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :announced, :boolean, default: false
  end
end
