class Api::V1::MealFoodsController < ApplicationController

  def create
    meal_food = MealFood.create!(meal_food_params)
    render json: meal_food
  end

  private

  def meal_food_params
    params.permit(:meal_id, :food_id)
  end
end