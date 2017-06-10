module ApplicationHelper

  def set_page_title(title)
    @page_title = title + " | West London Coders"
  end

  def set_page_description(description)
    @page_description = description || "Dive into web development with relaxed and friendly developers at the stunning NET-A-PORTER HQ in Westfield, White City."
  end

  def set_page_image(image)
    @page_image = image || "http://westlondoncoders.com/img/general/twitter.jpg"
  end

  def page_twitter(twitter)
    @page_twitter = twitter || @user.twitter || @post.created_by.twitter || "@westlondoncode"
  end

  def avatar_url(user)
    if user.image.file.nil?
      default_url = "https://s3.eu-west-2.amazonaws.com/wlcimages/avatar.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=#{CGI.escape(default_url)}"
    else
      user.image
    end
  end

  def user_in_hackroom?(hackroom, user)
    UserHackroom.find_by(hackroom: hackroom, user: user)
  end

  def user_attending_meetup?(meetup, user)
    MeetupRsvp.find_by(meetup: meetup, user: user)
  end

  def user_options_for_select(users, selected = nil)
    options_for_select(users.map { |u| [u.name, u.id] }, selected)
  end

  def language_options_for_select(languages, selected = nil)
    options_for_select(languages.map { |l| [l.name, l.id] }, selected)
  end

  def relative_time(date)
    sentence = time_ago_in_words(date)
    sentence.slice(0, 1).capitalize + sentence.slice(1..-1)
  end

  def time_as_sentence(date)
    date.past? ? "#{relative_time(date)} ago" : "In #{relative_time(date)}"
  end

  def date_and_time_as_sentence(date)
    "#{time_as_sentence(date)}, #{date.to_date.to_formatted_s(:short)}"
  end

  def excerpt(text, length = 250)
    sanitize text.truncate(length, escape: false, omission: '...')
  end
end
