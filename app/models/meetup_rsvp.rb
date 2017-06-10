class MeetupRsvp < ActiveRecord::Base
  after_create :announce_rsvp
  after_destroy :announce_rsvp_cancelled

  belongs_to :meetup
  belongs_to :user

  delegate :url_helpers, to: 'Rails.application.routes'

  def announce_rsvp
    message = "#{user.name} is now attending the meetup on #{meetup.date.to_date.to_formatted_s(:long_ordinal)} at #{meetup.sponsor.name} #{meetup_path}"
    Slacked.post_async message, channel: slack_channel, username: 'Hackroom Bot'
  end

  def announce_rsvp_cancelled
    message = "#{user.name} can no longer attend the meetup on #{meetup.date.to_date.to_formatted_s(:long_ordinal)} at #{meetup.sponsor.name} #{meetup_path}"
    Slacked.post_async message, channel: slack_channel, username: 'Hackroom Bot'
  end

  def meetup_path
    "http://westlondoncoders.com" + Rails.application.routes.url_helpers.meetup_path(meetup)
  end

  def slack_channel
    Rails.env.production? ? 'rsvp-notifications' : 'testing'
  end
end
