class Basic::LanguagesApi < Grape::API
  get do
    present Language.all, with: Basic::Entities::Language
  end

  route_param :slug, type: String do
    get do
      language = Language.find_by_slug(params[:slug])

      unless language
        error! 'Not Found', 404
      end

      present language, with: Basic::Entities::Language
    end
  end
end
