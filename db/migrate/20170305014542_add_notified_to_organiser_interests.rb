class AddNotifiedToOrganiserInterests < ActiveRecord::Migration[4.2]
  def change
    add_column :organiser_interests, :notified_at, :datetime, default: nil
  end
end
