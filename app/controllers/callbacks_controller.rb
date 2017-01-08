class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in(@user, event: :authentication)
      redirect_to after_sign_in_path_for(@user)
    end
  end
end
