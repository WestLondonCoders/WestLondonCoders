class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in(@user, event: :authentication)
      if @user.name == ""
        redirect_to edit_user_path(@user)
      else
        redirect_to root_path
      end
    end
  end
end
