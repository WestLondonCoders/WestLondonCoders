class InterestsController < ApplicationController
    before_action :require_sign_in, only: [:index, :show]

  def index
    @search = Interest.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @interests = @search.result.includes(:users)
  end

  def search
    index
    render :index
  end

  def show
  end

  def add_this_interest(interest, user)
    UserInterest.create(interest_id: interest, user_id: user)
  end

  private

  def interest_params
    params.permit(:id)
  end
end
