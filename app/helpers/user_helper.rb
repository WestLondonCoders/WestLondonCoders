module UserHelper
  def social_url(handle, site)
    link_to "https://#{site}.com/#{handle}", target: '_blank' do
      content_tag(:i, nil, class: ["fa", "fa-#{site}"])
    end
  end
end
