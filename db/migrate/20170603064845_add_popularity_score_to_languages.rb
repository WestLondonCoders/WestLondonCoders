class AddPopularityScoreToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :popularity_score, :integer, default: 0
  end
end
