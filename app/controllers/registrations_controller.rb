class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  def create
    super
    UserMailer.welcome_email(resource).deliver unless resource.invalid?
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, primary_language_ids: [])
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
