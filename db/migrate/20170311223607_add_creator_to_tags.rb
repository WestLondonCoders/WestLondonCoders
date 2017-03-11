class AddCreatorToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :creator, references: :users, index: true
  end
end
