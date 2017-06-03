class BackfillLanguagePopularity < ActiveRecord::Migration
  def change
    Language.all.each do |l|
      l.popularity_score = l.users.size + l.primary_users.size
      l.save
    end
  end
end
