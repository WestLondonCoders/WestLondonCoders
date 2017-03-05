class OrganiserInterestsController < ApplicationController
  def create
    interest = OrganiserInterest.find_by(user: current_user)
    unless interest
      OrganiserInterest.create!(user: current_user)
    end
    redirect_to organisers_path, notice: "Thanks for your interest! We'll be in touch 😉"
  end
end
