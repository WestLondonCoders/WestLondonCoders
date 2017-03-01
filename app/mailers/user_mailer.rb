class UserMailer < ApplicationMailer
  include SendGrid
  default from: 'West London Coders <people@westlondoncoders.com>'

  def welcome_email(user)
    headers['X-SMTPAPI'] = '{"filters":{"subscriptiontrack":{"settings":{"enable":1,"text/html":"<%Unsubscribe%>","text/plain":"<% %>"}}}}'
    @user = user
    mail to: user.email, subject: "Welcome to West London Coders!"
  end
end
