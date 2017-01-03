class UserSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill, dependent: :destroy
end
