class SplitUserNamesIntoFirstAndLast < ActiveRecord::Migration
  def change
    User.all.each do |user|
      first_name, last_name = user.name.split
      user.first_name = first_name
      user.last_name = last_name || ''
      user.save
    end
  end
end
