class UpdateLanguagePopularity < ActiveRecord::Migration
  def change
    Language.all.each do |l|
      l.popularity_score = l.users.size + (l.primary_users.size * 2) + (l.hackroom_primaries.size * 2) + l.hackrooms.size
      l.save
    end
  end
end
