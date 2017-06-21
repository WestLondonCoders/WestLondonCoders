module UserHelper
  def social_url(handle, site)
    link_to "https://#{site}.com/#{handle}", target: '_blank' do
      content_tag(:i, nil, class: ["fa", "fa-#{site}"])
    end
  end

  def hackroom_count(user)
    hackrooms = user.own_hackrooms.size + user.hackrooms.size
    pluralize(hackrooms, 'hackroom')
  end

  def language_count(user)
    languages = user.primary_languages.size + user.languages.size
    pluralize(languages, 'language')
  end

  def post_count(user)
    pluralize(user.posts.size, 'post')
  end

  def meetup_count(user)
    pluralize(user.meetups.size, 'meetup')
  end

  def list_all_sentence(users)
    users.map { |u| link_to(u.name, user_path(u)) }.to_sentence
  end

  def list_all(users)
    users.map { |u| link_to(u.name, user_path(u)) }.join(', ')
  end

  def remaining_follow_count(user)
    pluralize((user.followers.count - 3), 'other person')
  end

  def user_follower_count(user)
    case user.followers.count
    when 0
      nil
    when 1..3
      "followed by #{list_all_sentence(user.followers.oldest_first)}".html_safe
    else
      "followed by #{list_all(user.followers.oldest_first.take(3))} and #{remaining_follow_count(user)}".html_safe
    end
  end

  def user_following?(current_user, user)
    current_user.followed_users.any? { |l| l == user }
  end

  def score(user)
    pluralize(number_with_delimiter(user.score, delimiter: ','), 'pt')
  end
end
