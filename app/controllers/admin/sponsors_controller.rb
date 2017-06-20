class Admin::SponsorsController < Admin::BaseController
  before_action :get_sponsor, only: [:update, :edit, :destroy]

  layout 'admin'

  def index
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to admin_sponsors_path, notice: 'Sponsor successfully created.'
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def update
    if @sponsor.update(sponsor_params)
      if current_user.has_role?(:admin)
        redirect_to admin_sponsors_path
      else
        redirect_to @sponsor, notice: 'Page updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @sponsor.destroy
    respond_to do |format|
      format.html { redirect_to admin_sponsors_path }
    end
  end

  private

  def get_sponsor
    @sponsor = Sponsor.friendly.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(:name, :description, :description_heading, :logo, :address, :link, :listed, user_ids: [], language_ids: [])
  end
end
