class JeromeFollowsEveryone < ActiveRecord::Migration
  def change
    User.all.each do |u|
      jerome = User.find_by_slug('jayzillachu')
      record = UserFollow.find_by(follower: jerome, user: u)
      next unless record || (record && record.user_id == jerome.id)
      UserFollow.create(follower: jerome, user: u)
      u.user_follows_count += 1
      Notification.create(user: u, notified_by: jerome, notifiable: u, action: 'followed')
    end
  end
end
