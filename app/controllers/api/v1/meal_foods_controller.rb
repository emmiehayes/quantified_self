class Api::V1::MealFoodsController < ApplicationController
  
  def create
    meal_food = MealFood.create!(meal_food_params)
    render json: meal_food, scope: { action: "create" }
  end

  def destroy
    meal_food = MealFood.find_relation(meal_food_params[:meal_id], meal_food_params[:food_id])
    render json: meal_food, scope: { action: "remove" } if meal_food.destroy
  end

  private

  def meal_food_params
    params.permit(:meal_id, :food_id)
  end
end