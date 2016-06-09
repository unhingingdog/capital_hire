class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = "Item listed"
      redirect_to root_path
    else
      flash[:error] = "Item was not listed"
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category, :rate)
  end

end
