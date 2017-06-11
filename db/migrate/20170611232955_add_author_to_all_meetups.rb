class AddAuthorToAllMeetups < ActiveRecord::Migration[5.1]
  def change
    Meetup.all.each do |m|
      m.author = User.first
      m.save
    end
  end
end
