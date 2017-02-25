class UserHackroom < ActiveRecord::Base
  belongs_to :hackroom
  belongs_to :user
end
