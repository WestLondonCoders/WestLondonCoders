class HackroomsController < ApplicationController
  before_action :get_hackroom, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :get_user, only: [:join, :leave]

  def index
    @search = Hackroom.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @hackrooms = @search.result.includes(:primary_languages, :languages)
    @languages = Language.all
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
    authorize! :edit, @hackroom
    @languages = Language.all
  end

  def update
    authorize! :update, @hackroom
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
      slack_announce_new_joiner if @hackroom.slack.present?
      redirect_to @hackroom
    end
  end

  def leave
    enrolment = UserHackroom.find_by(hackroom: @hackroom, user: @user)

    if enrolment
      enrolment.destroy
      enrolment.save
      flash[:alert] = "You've left this hackroom."
      slack_announce_new_leaver if @hackroom.slack.present?
      redirect_to @hackroom
    else
      flash[:alert] = "You weren't in this hackroom."
      redirect_to @hackroom
    end
  end

  def destroy
    authorize! :destroy, @hackroom
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
      Slacked.post_async "#{current_user.name} created a hackroom: #{@hackroom.name} #{hackroom_url(@hackroom)}", {channel: 'general', username: 'Hackroom Bot'}
    else
      Slacked.post_async "#{current_user.name} created a hackroom: #{@hackroom.name} #{hackroom_url(@hackroom)}", {channel: 'testing', username: 'Hackroom Bot'}
    end
  end

  def slack_announce_new_joiner
    if Rails.env.production?
      Slacked.post_async "#{current_user.name} joined the hackroom! #{user_url(current_user)}", {channel: "#{@hackroom.slack}", username: 'Hackroom Bot'}
    else
      Slacked.post_async "#{current_user.name} joined the hackroom! #{user_url(current_user)}", {channel: 'testing', username: 'Hackroom Bot'}
    end
  end

  def slack_announce_new_leaver
    if Rails.env.production?
      Slacked.post_async "#{current_user.name} left the hackroom! #{user_url(current_user)}", {channel: "#{@hackroom.slack}", username: 'Hackroom Bot'}
    else
      Slacked.post_async "#{current_user.name} left the hackroom! #{user_url(current_user)}", {channel: "testing", username: 'Hackroom Bot'}
    end
  end
end
