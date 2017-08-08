class Basic::Entities::Language < Grape::Entity
  include Basic::Helpers::HrefHelpers

  expose :name
  expose :slug, as: :id
  expose(:href) do |language, options|
    language_href(language, options)
  end

  with_options unless: { type: :identity } do
    expose :description

    expose :hackrooms do |language, options|
      Basic::Entities::Hackroom.represent language.primary_hackrooms.active, options.merge(type: :identity)
    end

    expose :likes do |language, options|
      Basic::Entities::Member.represent language.primary_users, options.merge(type: :identity)
    end
  end
end
