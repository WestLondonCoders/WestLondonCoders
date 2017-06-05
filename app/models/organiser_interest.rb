class OrganiserInterest < ActiveRecord::Base
  after_create :notify

  belongs_to :user

  validates :user, uniqueness: true

  def notify
    Slacked.post_async slack_message, channel: 'organiser-interest', username: 'Organiser Bot'
    UserMailer.organiser_promotion(user).deliver_now
    update(notified_at: Time.now)
  end

  def slack_message
    "#{user.name} is interested in being an organiser. Here's their email: #{user.email}"
  end
end
