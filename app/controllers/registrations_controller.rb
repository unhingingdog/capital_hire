class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(signup_params)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation)
  end
end
