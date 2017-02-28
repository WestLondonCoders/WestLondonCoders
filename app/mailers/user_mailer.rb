class UserMailer < ApplicationMailer
  default from: 'people@westlondoncoders.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to West London Coders')
  end
end
