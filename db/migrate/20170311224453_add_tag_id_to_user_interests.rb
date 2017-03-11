class AddTagIdToUserInterests < ActiveRecord::Migration
  def change
    add_reference :user_interests, :tag, references: :tags, index: true
  end
end
