class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @listings = Item.where(user_id: @user.id)
    @orders = Order.where(lessor_id: @user.id)
    @hires = Order.where(borrower_id: @user.id)
  end
end
