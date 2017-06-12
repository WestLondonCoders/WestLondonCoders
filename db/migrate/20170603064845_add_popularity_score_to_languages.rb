class AddPopularityScoreToLanguages < ActiveRecord::Migration[4.2]
  def change
    add_column :languages, :popularity_score, :integer, default: 0
  end
end
