class AddFinishTimeToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :finish_date, :datetime
  end
end
