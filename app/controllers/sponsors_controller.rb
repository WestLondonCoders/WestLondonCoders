class SponsorsController < ApplicationController
  before_action :get_sponsor, only: [:show]
  load_and_authorize_resource

  def index
    @sponsors = Sponsor.listed
  end

  private

  def get_sponsor
    @sponsor = Sponsor.friendly.find(params[:id])
  end
end
