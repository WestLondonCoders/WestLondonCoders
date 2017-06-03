class AddFinishTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :finish_date, :datetime
  end
end
