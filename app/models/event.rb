class Event < ActiveRecord::Base
  has_many :event_rsvps
  has_many :rsvps, through: :event_rsvps, source: :user

  belongs_to :sponsor

  has_many :organisers, -> { with_role(:organiser) }, through: :event_rsvps, source: :user
  has_many :languages, -> { distinct }, through: :rsvps, source: :primary_languages
end
