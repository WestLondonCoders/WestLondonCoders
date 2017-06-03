class UserFollow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  belongs_to :user, foreign_key: :user_id, counter_cache: true
end
