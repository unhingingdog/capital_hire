class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(sign_up_params)
    if @user.save
      redirect_to root_path
    else
      flash[:error] = "user not created"
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation)
  end
end
