class AddAuthorToMeetups < ActiveRecord::Migration[5.1]
  def change
    add_column :meetups, :author_id, :integer, references: :user
  end
end
