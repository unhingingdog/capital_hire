class ItemsController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!, except: [:index, :show, :home, :search_results]

  def home
  end

  def search_results
    if(params[:query])
      @items = Item.text_search(params[:query]).page(params[:page]).per_page(3)
    end
  end

  def hire

  end

  def index
    if params[:category].blank?
      @items = Item.all.order("created_at DESC").page(params[:page]).per_page(20)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @items = Item.where(category_id: @category_id).order("created_at DESC").page(params[:page]).per_page(20)
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
    params.require(:item).permit(:title, :description, :category_id, :rate,
                                :image, :location_id, :specs, :address, :latitude, :longitude)
  end

end
