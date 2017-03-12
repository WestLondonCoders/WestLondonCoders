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

  def interest_count(user)
    pluralize(user.interests.size, 'interest')
  end

  def language_count(user)
    languages = user.primary_languages.size + user.languages.size
    pluralize(languages, 'language')
  end

  def post_count(user)
    pluralize(user.posts.size, 'post')
  end

  def meetup_count(user)
    pluralize(user.events.size, 'meetup')
  end
end
