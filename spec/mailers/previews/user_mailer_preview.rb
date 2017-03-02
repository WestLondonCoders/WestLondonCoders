# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def rsvp_confirmation
    UserMailer.rsvp_confirmation(User.first, Event.first)
  end

  def unrsvp_confirmation
    UserMailer.unrsvp_confirmation(User.first, Event.first)
  end
end
