class AddAuthorToAllHackrooms < ActiveRecord::Migration[5.1]
  def change
    Hackroom.all.each do |l|
      if l.owners.any?
        l.author = l.owners.first
      else
        l.author = User.first
      end
      l.save
    end
  end
end
