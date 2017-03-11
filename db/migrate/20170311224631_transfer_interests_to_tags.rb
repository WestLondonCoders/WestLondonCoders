class TransferInterestsToTags < ActiveRecord::Migration
  def change
    UserInterest.all.each do |user_interest|
      unless user_interest.user.present? && user_interest.interest.present?
        user_interest.destroy
        user_interest.save
      end

      user_interest.tag = Tag.find_or_create_by(name: user_interest.interest.name)
      user_interest.save
      user_interest.tag.creator_id = user_interest.user
    end
  end
end
