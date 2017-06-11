class AddAuthorToAllLanguages < ActiveRecord::Migration[5.1]
  def change
    Language.all.each do |l|
      l.author = User.first
      l.save
    end
  end
end
