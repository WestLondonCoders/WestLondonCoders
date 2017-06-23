# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def rsvp_confirmation
    UserMailer.rsvp_confirmation(User.first, Meetup.last)
  end

  def unrsvp_confirmation
    UserMailer.unrsvp_confirmation(User.first, Meetup.last)
  end

  def organiser_promotion
    UserMailer.organiser_promotion(User.first)
  end

  def meetup_scheduled
    UserMailer.meetup_scheduled(Meetup.last, User.first)
  end
end
