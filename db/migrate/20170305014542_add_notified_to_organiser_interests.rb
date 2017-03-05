class AddNotifiedToOrganiserInterests < ActiveRecord::Migration
  def change
    add_column :organiser_interests, :notified_at, :datetime, default: nil
  end
end
