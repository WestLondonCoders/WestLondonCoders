class Event < ActiveRecord::Base
  has_many :event_rsvps
  has_many :rsvps, through: :event_rsvps, source: :user

  has_many :event_sponsors
  has_many :venues, through: :event_sponsors, source: :sponsor
end
