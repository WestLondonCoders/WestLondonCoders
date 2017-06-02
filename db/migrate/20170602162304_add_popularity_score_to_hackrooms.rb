class AddPopularityScoreToHackrooms < ActiveRecord::Migration
  def change
    add_column :hackrooms, :popularity_score, :integer, default: 0
  end
end
