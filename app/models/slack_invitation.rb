class SlackInvitation < ActiveRecord::Base
  belongs_to :user

  def invite_url
    "https://slack.com/api/users.admin.invite?token=#{ENV['SLACK_TOKEN']}&email=#{email}"
  end
end
