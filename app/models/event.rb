class Event < ActiveRecord::Base
  has_many :rsvps, class_name: "User"
end
