module Basic::Helpers::HrefHelpers
  def member_href(member, options)
    "#{href_api_base_url(options)}members/#{member.slug}"
  end

  def hackroom_href(hackroom, options)
    "#{href_api_base_url(options)}hackrooms/#{hackroom.slug}"
  end

  def language_href(language, options)
    "#{href_api_base_url(options)}languages/#{language.slug}"
  end

  private

  def href_api_base_url(options)
    "#{options[:env]['rack.url_scheme']}://#{options[:env]['HTTP_HOST']}/api/"
  end
end
