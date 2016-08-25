class ItemsController < ApplicationController
  require 'will_paginate/array'
  before_action :authenticate_user!, except: [:index, :show, :home, :search_results]

  def home
  end

  def search_results
    category = find_category_id(params[:category])
    location = find_location_id(params[:location])
    query = params[:query]
    @items = Item.searcher(query, location, category).order("created_at DESC").page(params[:page]).per_page(20)
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

  def find_category_id(category_name)
    category_name.blank? ? nil : Category.find_by(name: category_name).id
  end

  def find_location_id(location_name)
    location_name.blank? ? nil : Location.find_by(name: location_name).id
  end

  # def searcher(query, location, category)
  #   unless query.blank?
  #     item = SearchService.new(Item)
  #     if location.blank? && category.blank?
  #       items = item.search(query)
  #     elsif location.blank?
  #       items = item.search(query).by_category(category)
  #     else
  #       items = item.search(query).by_location(location)
  #     end
  #   else
  #     if category.blank? && location.blank?
  #       items = Item.all
  #     elsif category.blank?
  #       items = Item.by_location(location)
  #     else
  #       items = Item.by_category(category)
  #     end
  #   end
  # end
end
