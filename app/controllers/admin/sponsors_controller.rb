class Admin::SponsorsController < Admin::BaseController
  before_action :get_sponsor, only: [:update, :edit, :destroy]

  layout 'admin'

  def index
    authorize! :manage, @sponsors
    @sponsors = Sponsor.all
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    authorize! :create, @sponsors
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to admin_sponsors_path, notice: 'Sponsor successfully created.'
    else
      flash[:alert] = "Error"
      render :new
    end
  end

  def update
    authorize! :update, @sponsors
    if @sponsor.update(sponsor_params)
      redirect_to admin_sponsors_path
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @sponsor
    @sponsor.destroy
    respond_to do |format|
      format.html { redirect_to admin_sponsors_path }
    end
  end

  private

  def get_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(:name, :description, :logo, :address)
  end
end
