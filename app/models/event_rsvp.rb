class EventRsvp < ActiveRecord::Base
  after_create :announce_rsvp
  after_destroy :announce_rsvp_cancelled

  belongs_to :event
  belongs_to :user

  delegate :url_helpers, to: 'Rails.application.routes'

  def announce_rsvp
    message = "#{user.name} is now attending the meetup on #{event.date.to_date.to_formatted_s(:long_ordinal)} at #{event.venues.first.name} #{event_path}"
    Slacked.post_async message, channel: slack_channel, username: 'Hackroom Bot'
  end

  def announce_rsvp_cancelled
    message = "#{user.name} can no longer attend the meetup on #{event.date.to_date.to_formatted_s(:long_ordinal)} at #{event.venues.first.name} #{event_path}"
    Slacked.post_async message, channel: slack_channel, username: 'Hackroom Bot'
  end

  def event_path
    "http://westlondoncoders.com" + Rails.application.routes.url_helpers.event_path(event)
  end

  def slack_channel
    Rails.env.production? ? 'rsvp-notifications' : 'testing'
  end
end
