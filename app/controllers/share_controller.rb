class ShareController < ApplicationController
    def users
        render json: User.pluck(:name), root: false
    end
end
