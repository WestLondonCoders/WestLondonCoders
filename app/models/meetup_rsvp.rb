class MeetupRsvp < ActiveRecord::Base
  after_create :announce_rsvp if  Rails.env.production?
  after_destroy :announce_rsvp_cancelled if  Rails.env.production?

  belongs_to :meetup
  belongs_to :user

  delegate :url_helpers, to: 'Rails.application.routes'

  def announce_rsvp
    message = "#{user.name} is now attending the meetup on #{meetup.start_date} at #{meetup.sponsor.name} #{meetup_path}"
    Slacked.post_async message, channel: 'rsvp-notifications', username: 'Hackroom Bot'
  end

  def announce_rsvp_cancelled
    message = "#{user.name} can no longer attend the meetup on #{meetup.start_date} at #{meetup.sponsor.name} #{meetup_path}"
    Slacked.post_async message, channel: 'rsvp-notifications', username: 'Hackroom Bot'
  end

  def meetup_path
    "http://westlondoncoders.com" + Rails.application.routes.url_helpers.meetup_path(meetup)
  end
end
