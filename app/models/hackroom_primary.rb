class HackroomPrimary < ActiveRecord::Base
  belongs_to :hackroom
  belongs_to :language, dependent: :destroy
end
