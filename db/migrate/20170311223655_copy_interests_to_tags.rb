class CopyInterestsToTags < ActiveRecord::Migration
  def change
    Interest.all.each do |interest|
      if interest.users.first
        Tag.create(name: interest.name, creator_id: interest.users.first.id)
      else
        Tag.create(name: interest.name)
      end
    end
  end
end
