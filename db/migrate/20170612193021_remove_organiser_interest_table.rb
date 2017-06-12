class RemoveOrganiserInterestTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :organiser_interests
  end
end
