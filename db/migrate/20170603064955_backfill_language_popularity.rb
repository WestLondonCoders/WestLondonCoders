class BackfillLanguagePopularity < ActiveRecord::Migration[4.2]
  def change
    Language.all.each do |l|
      l.popularity_score = l.users.size + l.primary_users.size
      l.save
    end
  end
end
