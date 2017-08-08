class Basic::Entities::Hackroom < Grape::Entity
  include Basic::Helpers::HrefHelpers

  expose :name
  expose :slug, as: :id
  expose(:href) do |hackroom, options|
    hackroom_href(hackroom, options)
  end

  with_options unless: { type: :identity } do
    expose :mission, as: :description
    expose :slack, as: :slack_channel

    expose :primary_languages do |hackroom, options|
      Basic::Entities::Language.represent hackroom.primary_languages, options.merge(type: :identity)
    end

    expose :secondary_languages do |hackroom, options|
      Basic::Entities::Language.represent hackroom.languages, options.merge(type: :identity)
    end

    expose :languages do |hackroom, options|
      Basic::Entities::Language.represent hackroom.all_languages, options.merge(type: :identity)
    end

    expose :members do |hackroom, options|
      Basic::Entities::Member.represent hackroom.users, options.merge(type: :identity)
    end
  end
end
