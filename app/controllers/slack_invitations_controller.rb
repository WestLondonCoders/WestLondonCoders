class SlackInvitationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invite = SlackInvitation.new
  end

  def create
    @invite = SlackInvitation.find_by(user: current_user, email: slack_invite_params[:email])
    if @invite
      redirect_to root_path, notice: 'Invitation sent, please check your email.'
    else
      @invite = SlackInvitation.new(slack_invite_params)
      @invite.user = current_user

      if @invite.save
        RestClient.get @invite.invite_url
        redirect_to root_path, notice: 'Invitation sent, please check your email.'
      else
        render :new, alert: 'Sorry, something went wrong there.'
      end
    end
  end

  private

  def slack_invite_params
    params.require(:slack_invitation).permit(:email)
  end
end

