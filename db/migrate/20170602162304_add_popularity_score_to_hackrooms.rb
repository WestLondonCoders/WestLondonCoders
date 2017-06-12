class AddPopularityScoreToHackrooms < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :hackrooms, :popularity_score, :integer, default: 0
  end
end
