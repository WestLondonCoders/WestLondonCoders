class UserMailer < ApplicationMailer
  include SendGrid
  default from: 'West London Coders <people@westlondoncoders.com>'

  def welcome_email(user)
    headers['X-SMTPAPI'] = '{"filters":{"subscriptiontrack":{"settings":{"enable":1,"text/html":"<%Unsubscribe%>","text/plain":"<% %>"}}}}'
    @user = user
    mail to: user.email, subject: "Welcome to West London Coders!"
  end

  def rsvp_confirmation(user, event)
    headers['X-SMTPAPI'] = '{"filters":{"subscriptiontrack":{"settings":{"enable":1,"text/html":"<%Unsubscribe%>","text/plain":"<% %>"}}}}'
    @user = user
    @event = event
    mail to: user.email, subject: "You're attending on #{@event.date.to_formatted_s(:long_ordinal)}!"
  end

  def unrsvp_confirmation(user, event)
    headers['X-SMTPAPI'] = '{"filters":{"subscriptiontrack":{"settings":{"enable":1,"text/html":"<%Unsubscribe%>","text/plain":"<% %>"}}}}'
    @user = user
    @event = event
    mail to: user.email, subject: "You're no longer attending on #{@event.date.to_formatted_s(:long_ordinal)}"
  end

  def organiser_promotion(interest)
    headers['X-SMTPAPI'] = '{"filters":{"subscriptiontrack":{"settings":{"enable":1,"text/html":"<%Unsubscribe%>","text/plain":"<% %>"}}}}'
    @user = interest.user
    mail to: @user.email, subject: "Thanks for your support!", from: 'Steve Brewer <steve@westlondoncoders.com>'
  end
end
