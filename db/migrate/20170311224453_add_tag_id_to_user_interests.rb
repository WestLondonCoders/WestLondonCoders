class AddTagIdToUserInterests < ActiveRecord::Migration[4.2]
  def change
    add_reference :user_interests, :tag, references: :tags, index: true
  end
end
