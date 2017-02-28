class EventsController < ApplicationController
  before_action :get_event, only: [:show]

  def index
    @search = Event.ransack(params[:q])
    @search.sorts = 'date asc' if @search.sorts.empty?
    @events = @search.result
  end

  def search
    index
    render :index
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end
end
