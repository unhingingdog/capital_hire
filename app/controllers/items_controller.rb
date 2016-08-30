class ItemsController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!, except: [:index, :show, :home, :search_results]

  def home
    @categories = Category.all.map{ |u| [ u.name, u.id ] }
    @locations = Location.all.map{ |u| [ u.name, u.id ] }
  end

  def search_results
    category = params[:category].empty? ? nil : params[:category].to_i
    location = params[:location].empty? ? nil : params[:location].to_i
    query = params[:query]
    @items = Item.searcher(params[:query], location, category).order("created_at DESC").page(params[:page]).per_page(20)
  end

  def index
    if params[:category].blank?
      @items = Item.all.order("created_at DESC").page(params[:page]).per_page(20)
    else
      category_id = find_category_id(params[:category])
      @items = Item.by_category(category_id).order("created_at DESC").page(params[:page]).per_page(20)
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
                                :image, :location_id, :specs, :address,
                                :latitude, :longitude, :category, :location)
  end
end
