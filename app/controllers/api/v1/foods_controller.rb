class Api::V1::FoodsController < ApplicationController
  before_action :set_food, only:[:show, :update, :destroy]

  def index
    render json: Food.all
  end

  def show
    render json: @food
  end

  def create 
    render json: Food.create!(food_params)
  end

  def update
    render json: @food if @food.update!(food_params)
  end

  def destroy
    @food.destroy
    head :no_content
  end

  private 

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.permit(:name, :calories)
  end
end
