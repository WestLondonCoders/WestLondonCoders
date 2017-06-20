class Admin::MeetupsController < Admin::BaseController
  before_action :get_meetup, only: [:show, :edit, :update, :destroy]
  after_action :post_new_meetup_slack_message, only: :create

  layout 'admin'

  def index
    @search = Meetup.ransack(params[:q])
    @search.sorts = 'date asc' if @search.sorts.empty?
    @upcoming_meetups = @search.result.upcoming
    @past_meetups = @search.result.past.reverse
    @meetups = @search.result
  end

  def search
    index
    render :index
  end

  def your_meetups
    authorize! :manage, current_user.managed_meetups.first
    @sponsor = current_user.sponsors.first
    @upcoming_meetups = current_user.managed_meetups.upcoming
    @past_meetups = current_user.managed_meetups.past
  end

  def new
    @meetup = Meetup.new
  end

  def create
    @meetup = Meetup.new(meetup_params)
    @meetup.author = current_user
    if @meetup.save
      create_slug
      notify_all(current_user, @meetup, 'scheduled a new meetup for') unless @meetup.date.past?
      redirect_to admin_meetups_path, notice: 'Meetup successfully created.'
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def update
    if @meetup.update(meetup_params)
      if current_user.has_role?(:admin)
        redirect_to admin_meetups_path
      else
        redirect_to admin_your_meetups_path
      end
    else
      render :edit
    end
  end

  def destroy
    @meetup.destroy
    respond_to do |format|
      format.html { redirect_to admin_meetups_path }
    end
  end

  private

  def get_meetup
    @meetup = Meetup.friendly.find(params[:id])
  end

  def meetup_params
    params.require(:meetup).permit(:name, :description, :address, :date, :sponsor_id, :slug, :finish_date)
  end

  def create_slug
    slug_date = @meetup.date.to_date.to_s.strip.downcase.tr(" ", "-").tr(",", "")
    slug_name = @meetup.name.strip.downcase.tr(" ", "-").tr(",", "")
    @meetup.update(slug: "#{slug_date}-#{slug_name}")
  end

  def post_new_meetup_slack_message
    if Rails.env.production?
      Slacked.post_async new_meetup_slack_message(meetup_url(@meetup), @meetup.start_date), channel: 'general', username: 'Schedule Bot'
    end
  end

  def new_meetup_slack_message(url, date)
    "A new meetup's been scheduled for #{date}! RSVP here: #{url}"
  end
end
