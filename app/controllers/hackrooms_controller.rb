class HackroomsController < ApplicationController
  before_action :get_hackroom, only: [:show, :edit, :update, :destroy, :join, :leave, :languages, :members, :admins, :discussion]
  before_action :get_user, only: [:join, :leave]
  skip_before_action :verify_authenticity_token, only: [:search]
  load_and_authorize_resource

  def discussion
    respond_to do |format|
      format.js
    end
  end

  def languages
    respond_to do |format|
      format.js
    end
  end

  def members
    respond_to do |format|
      format.js
    end
  end

  def admins
    respond_to do |format|
      format.js
    end
  end

  def index
    @search = Hackroom.ransack(params[:q])
    @hackrooms = @search.result.includes(:primary_languages, :languages, :owners, :users).in_popularity_order
    @languages = Language.all
  end

  def search
    index
    render :index
  end

  def new
    @hackroom = Hackroom.new
  end

  def create # rubocop:disable Metrics/MethodLength
    @hackroom = Hackroom.new(hackroom_params)
    respond_to do |format|
      if @hackroom.save
        HackroomOwner.create(hackroom: @hackroom, user: current_user) unless @hackroom.owners.any?
        slack_announce_new_hackroom
        format.html { redirect_to @hackroom, notice: 'Hackroom created successfully.' }
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
    enrolment.present? ? remove_user_from_hackroom(enrolment) : add_user_to_hackroom
    redirect_to @hackroom if @hackroom.save
  end

  def destroy
    @hackroom.destroy
    respond_to do |format|
      format.html { redirect_to hackrooms_path }
    end
  end

  private

  def get_hackroom
    @hackroom = Hackroom.friendly.find(params[:id])
  end

  def get_user
    @user = current_user
  end

  def hackroom_params
    params.require(:hackroom).permit(:name, :mission, :slack, :project_url, :slug, user_ids: [], owner_ids: [], primary_language_ids: [], language_ids: [])
  end

  def require_hackroom_admin
    unless current_user.is_hackroom_admin?(@hackroom) || user_is_admin
      redirect_to hackroom_path(@hackroom)
      flash[:alert] = "You're not authorised to do that"
    end
  end

  def slack_announce_new_hackroom
    if Rails.env.production?
      Slacked.post_async "#{current_user.name} created a hackroom: #{@hackroom.name} #{hackroom_url(@hackroom)}", channel: 'general', username: 'Hackroom Bot'
    else
      Slacked.post_async "#{current_user.name} created a hackroom: #{@hackroom.name} #{hackroom_url(@hackroom)}", channel: 'testing', username: 'Hackroom Bot'
    end
  end

  def remove_user_from_hackroom(enrolment)
    enrolment.destroy
    @hackroom.popularity_score -= 1
    flash[:alert] = "You've left this hackroom."
  end

  def add_user_to_hackroom
    UserHackroom.create(hackroom: @hackroom, user: @user)
    @hackroom.popularity_score += 1
    flash[:alert] = 'You joined this hackroom!'
  end
end
