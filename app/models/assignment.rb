class Assignment < ActiveRecord::Base
  belongs_to :role, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
