class BackfillHackroomPopularityScore < ActiveRecord::Migration[4.2][4.2]
  def change
    Hackroom.all.each do |hr|
      hr.popularity_score = hr.users.size
      hr.save
    end
  end
end
