class Basic::MembersApi < Grape::API
  get do
    present User.all, with: Basic::Entities::Member
  end

  route_param :slug, type: String do
    get do
      member = User.find_by_slug(params[:slug])

      unless member
        error! 'Not Found', 404
      end

      present member, with: Basic::Entities::Member
    end
  end
end
