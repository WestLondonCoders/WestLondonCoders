class HackroomsController < ApplicationController
  before_action :get_hackroom, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :get_user, only: [:join, :leave]
  before_action :require_sign_in, only: [:new, :create, :update]
  before_action :require_hackroom_admin, only: [:edit, :update, :destroy]

  def index
    @search = Hackroom.ransack(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @hackrooms = @search.result.includes(:primary_languages, :languages)
  end

  def search
    index
    render :index
  end

  def new
    @hackroom = Hackroom.new
  end

  def create
    @hackroom = Hackroom.new(hackroom_params)
    @hackroom.slug = @hackroom.name.downcase.gsub(" ", "-")

    respond_to do |format|
      if @hackroom.save
        slack
        format.html { redirect_to hackrooms_path, notice: 'Hackroom created successfully.' }
      else
        flash[:alert] = 'Something went wrong.'
        format.html { render :new }
      end
    end
  end

  def edit
    @languages = Language.all
  end

  def update
    respond_to do |format|
      if @hackroom.update(hackroom_params)
        format.html { redirect_to @hackroom, notice: 'Hackroom was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def join
    enrolment = UserHackroom.find_by(hackroom: @hackroom, user: @user)

    if enrolment.present?
      flash[:alert] = "You're already in this hackroom."
      redirect_to @hackroom
    else
      UserHackroom.create(hackroom: @hackroom, user: @user)
      flash[:alert] = 'You joined this hackroom!'
      redirect_to @hackroom
    end
  end

  def leave
    enrolment = UserHackroom.find_by(hackroom: @hackroom, user: @user)

    if enrolment
      enrolment.destroy
      enrolment.save
      flash[:alert] = "You've left this hackroom."
      redirect_to @hackroom
    else
      flash[:alert] = "You weren't in this hackroom."
      redirect_to @hackroom
    end
  end

  def destroy
    @hackroom.destroy
    respond_to do |format|
      format.html { redirect_to hackrooms_path }
    end
  end

  private

  def get_hackroom
    @hackroom = Hackroom.find(params[:id])
  end

  def get_user
    @user = current_user
  end

  def hackroom_params
    params.require(:hackroom).permit(:name, :mission, :slack, :project_url, :slug, owner_ids: [], primary_language_ids: [], language_ids: [])
  end

  private

    def require_hackroom_admin
      unless current_user.is_hackroom_admin?(@hackroom) || user_is_admin
        redirect_to hackroom_path(@hackroom)
        flash[:alert] = "You're not authorised to do that"
      end
    end

    def slack
      Slacked.post_async "#{current_user.name} created a hackroom: #{@hackroom.name} #{hackroom_url(@hackroom)}",
                          {channel: 'general', username: 'Hackroom Bot'}
    end
end
