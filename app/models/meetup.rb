class Meetup < ActiveRecord::Base
  belongs_to :sponsor
  has_many :meetup_rsvps
  has_many :rsvps, through: :meetup_rsvps, source: :user
  has_many :sponsor_admins, through: :sponsor, source: :users
  has_many :organisers, -> { with_role("Organiser") }, through: :meetup_rsvps, source: :user
  has_many :languages, -> { distinct }, through: :rsvps, source: :primary_languages
  has_many :comments, as: :commentable
  belongs_to :author, class_name: 'User'

  scope :upcoming, -> { where("date >= ?", Date.today) }
  scope :past, -> { where("date <= ?", Date.today) }
  scope :in_upcoming_order, -> { upcoming.order('date asc') }

  validates_presence_of :name, :sponsor, :date, :finish_date

  extend FriendlyId
  friendly_id :slug, use: :slugged

  def start_date
    date.to_date.to_formatted_s(:long_ordinal)
  end

  def end_date
    finish_date.to_date.to_formatted_s(:long_ordinal)
  end

  def past?
    date.past?
  end

  def title
    name
  end
end
