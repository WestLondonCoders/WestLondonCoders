class SteveFollowsEveryone < ActiveRecord::Migration
  def change
    User.all.each do |u|
      record = UserFollow.find_by(follower: User.find(1), user: u)
      next unless record
      steve = User.find(1)
      UserFollow.create(follower: steve, user: u)
      u.user_follows_count += 1
      Notification.create(user: u, notified_by: steve, notifiable: u, action: 'followed')
    end
  end
end
