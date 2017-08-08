class Basic::HackroomsApi < Grape::API
  get do
    present Hackroom.active.all, with: Basic::Entities::Hackroom
  end

  route_param :slug, type: String do
    get do
      hackroom = Hackroom.find_by_slug(params[:slug])

      unless hackroom
        error! 'Not Found', 404
      end

      present hackroom, with: Basic::Entities::Hackroom
    end
  end
end
