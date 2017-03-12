class Event < ActiveRecord::Base
  has_many :event_rsvps
  has_many :rsvps, through: :event_rsvps, source: :user

  belongs_to :sponsor
  has_many :sponsor_admins, through: :sponsor, source: :users

  has_many :organisers, -> { with_role("Organiser") }, through: :event_rsvps, source: :user
  has_many :languages, -> { distinct }, through: :rsvps, source: :primary_languages

  scope :upcoming, lambda { where("date >= ?", Date.today) }
  scope :past, lambda { where("date <= ?", Date.today) }

  extend FriendlyId
  friendly_id :slug, use: :slugged
end
