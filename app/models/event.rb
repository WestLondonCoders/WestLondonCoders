class Event < ActiveRecord::Base
  belongs_to :sponsor
  has_many :event_rsvps
  has_many :rsvps, through: :event_rsvps, source: :user
  has_many :sponsor_admins, through: :sponsor, source: :users
  has_many :organisers, -> { with_role("Organiser") }, through: :event_rsvps, source: :user
  has_many :languages, -> { distinct }, through: :rsvps, source: :primary_languages

  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :past, -> { where("date <= ?", Date.today) }
  scope :in_upcoming_order, -> { upcoming.order('date asc') }

  extend FriendlyId
  friendly_id :slug, use: :slugged

  def start_date
    date.to_date.to_formatted_s(:long_ordinal)
  end

  def past?
    date.past?
  end
end
