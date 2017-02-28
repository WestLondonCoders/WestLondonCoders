class Admin::EventsController < Admin::BaseController
  before_action :get_event, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  def index
    authorize! :manage, @events
    @search = Event.ransack(params[:q])
    @search.sorts =  'date asc' if @search.sorts.empty?
    @events = @search.result
  end

  def search
    index
    render :index
  end

  def new
    @event = Event.new
  end

  def create
    authorize! :create, @events
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path, notice: 'Event successfully created.'
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def update
    authorize! :update, @events
    if @event.update(event_params)
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_path }
    end
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date)
  end
end
