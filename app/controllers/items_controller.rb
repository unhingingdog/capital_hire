class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:category].blank?
      @items = Item.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @items = Item.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      flash[:notice] = "Item listed"
      redirect_to item_path(@item)
    else
      flash[:error] = "Item was not listed"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :rate, :image)
  end

end
