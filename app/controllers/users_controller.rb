class UsersController < ApplicationController
  before_action :get_user,                only: [:show, :edit, :update,
                                                 :edit_interests, :edit_skills]
  before_action :require_admin_or_owner,  only: [:edit, :edit_interests,
                                                 :edit_skills, :update]

  def show
    @posts = Post.all.where(created_by_id: @user).order("created_at desc")
  end

  def index
    @search = User.ransack(params[:q])
    @search.sorts = 'last_active_at asc' if @search.sorts.empty?
    @users = @search.result.includes(:interests, :skills)
  end

  def search
    index
    render :index
  end

  def edit
  end

  def edit_interests
  end

  def edit_skills
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(user_params)
    else
      render :edit
    end
  end

  private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user].permit(:name, :bio, :job_title, :twitter,
                           :instagram, :github, :facebook, :linkedin,
                           :website_url, interests_attributes:
                           [:id, :name, :_destroy],
                           skills_attributes: [:id, :name, :_destroy])
    end

    def require_admin_or_owner
      unless this_user_or_admin(current_user)
        redirect_to :back
        flash[:alert] = "You're not authorised to do that"
      end
    end
end
