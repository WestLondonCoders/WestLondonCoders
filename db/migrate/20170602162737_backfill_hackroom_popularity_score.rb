class BackfillHackroomPopularityScore < ActiveRecord::Migration
  def change
    Hackroom.all.each do |hr|
      hr.popularity_score = hr.users.size
      hr.save
    end
  end
end
