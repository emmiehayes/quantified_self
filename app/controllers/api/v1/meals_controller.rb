class Api::V1::MealsController < ApplicationController
  before_action :set_meal, only:[:show]

  def index
    render json: Meal.all
  end

  def show
    render json: @meal
  end

  private 

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end
end
