class OrganiserInterestsController < ApplicationController
  def create
    OrganiserInterest.create!(user: current_user)
    redirect_to organisers_path, notice: "Thanks for your interest! We'll be in touch 😉"
  end
end
