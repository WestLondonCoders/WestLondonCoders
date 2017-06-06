class ConvertSlugsToUsernames < ActiveRecord::Migration
  def change
    User.all.each do |u|
      if u.username == nil || ''
        u.username = u.slug.gsub(/\W+/, '')
        u.save
      end
    end
  end
end
