class Api::V1::FavoriteFoodsController < ApplicationController

  def index 
    @presenter = FavoriteFoodsPresenter.new
    render json: @presenter.favorite_foods
  end
end