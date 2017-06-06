class ShareController < ApplicationController
  def users
    @users = User.all
    @userlist = @users.map do |u|
      { name: u.name, username: u.username, path: user_path(u), img: u.image.url }
    end
    render json: @userlist, root: false
  end
end
