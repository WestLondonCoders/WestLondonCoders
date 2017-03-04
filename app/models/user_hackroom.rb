class UserHackroom < ActiveRecord::Base
  after_create :announce_joining
  after_destroy :announce_leaving

  belongs_to :hackroom
  belongs_to :user

  delegate :url_helpers, to: 'Rails.application.routes'

  def announce_joining
    if hackroom.slack.present?
      Slacked.post_async message(user, 'joined'), channel: slack_channel, username: 'Hackroom Bot'
    end
  end

  def announce_leaving
    if hackroom.slack.present?
        Slacked.post_async message(user, 'left'), channel: slack_channel, username: 'Hackroom Bot'
    end
  end

  def message(user, action)
    profile_path = Rails.application.routes.url_helpers.user_path(user)
    "#{user.name} #{action} the hackroom! http://westlondoncoders.com#{profile_path}"
  end

  def slack_channel
    Rails.env.production? ? hackroom.slack : 'testing'
  end
end
