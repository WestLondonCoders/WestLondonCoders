class EventsController < ApplicationController
  before_action :get_event, only: [:show, :rsvp]

  def show
    authorize! :manage, @event
  end

  def index
    authorize! :manage, @events
    @search = Event.upcoming.ransack(params[:q])
    @search.sorts = 'date asc' if @search.sorts.empty?
    @events = @search.result
  end

  def search
    index
    render :index
  end

  def past_events
    @past_events = Event.past.all
  end

  def rsvp # rubocop:disable Metrics/MethodLength
    rsvp = EventRsvp.find_by(event: @event, user: current_user)

    if rsvp.present?
      rsvp.destroy
      UserMailer.unrsvp_confirmation(current_user, @event).deliver
      flash[:alert] = "Thanks for updating your RSVP."
    else
      EventRsvp.create(event: @event, user: current_user)
      UserMailer.rsvp_confirmation(current_user, @event).deliver
      flash[:alert] = "You're coming to this meetup!"
    end
    redirect_to @event
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end
end
