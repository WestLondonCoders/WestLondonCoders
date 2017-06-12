class AddCreatorToTags < ActiveRecord::Migration[4.2]
  def change
    add_reference :tags, :creator, references: :users, index: true
  end
end
