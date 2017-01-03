class Interest < ActiveRecord::Base
  has_many :user_interests
  has_many :users, through: :user_interests
end
