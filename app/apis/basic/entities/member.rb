class Basic::Entities::Member < Grape::Entity
  include Basic::Helpers::HrefHelpers

  expose :name
  expose :slug, as: :id
  expose(:href) do |member, options|
    member_href(member, options)
  end

  with_options unless: { type: :identity } do
    expose :first_name
    expose :last_name
    expose :location

    expose :hackrooms do |member, options|
      Basic::Entities::Hackroom.represent member.hackrooms.active, options.merge(type: :identity)
    end

    expose :primary_languages do |member, options|
      Basic::Entities::Language.represent member.primary_languages, options.merge(type: :identity)
    end

    expose :secondary_languages do |member, options|
      Basic::Entities::Language.represent member.languages, options.merge(type: :identity)
    end

    expose :languages do |member, options|
      Basic::Entities::Language.represent member.all_languages, options.merge(type: :identity)
    end
  end
end
