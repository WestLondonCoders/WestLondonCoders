class EventsController < ApplicationController
  before_action :get_event, only: [:show, :rsvp, :unrsvp]
  before_action :get_user, only: [:rsvp, :unrsvp]

  def show
    authorize! :manage, @event
  end

  def index
    authorize! :manage, @events
    @search = Event.ransack(params[:q])
    @search.sorts = 'date asc' if @search.sorts.empty?
    @events = @search.result
  end

  def search
    index
    render :index
  end

  def rsvp
    rsvp = EventRsvp.find_by(event: @event, user: @user)

    if rsvp.present?
      flash[:alert] = "You're already coming to this meetup."
      redirect_to @event
    else
      EventRsvp.create(event: @event, user: @user)
      UserMailer.rsvp_confirmation(@user, @event).deliver
      flash[:alert] = "You're coming to this meetup!"
      redirect_to @event
    end
  end

  def unrsvp
    rsvp = EventRsvp.find_by(event: @event, user: @user)

    if rsvp
      rsvp.destroy
      rsvp.save
      UserMailer.unrsvp_confirmation(@user, @event).deliver
      flash[:alert] = "Thanks for updating your RSVP."
      redirect_to @event
    else
      flash[:alert] = "Something went wrong."
      redirect_to @event
    end
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def get_user
    @user = current_user
  end
end
