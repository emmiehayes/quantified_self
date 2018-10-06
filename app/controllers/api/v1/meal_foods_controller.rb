class Api::V1::MealFoodsController < ApplicationController
  
  def create
    meal_food = MealFood.create!(meal_food_params)
    render json: meal_food, scope: { action: "create" }
  end

  def destroy
    meal_food = MealFood.where('meal_id = ? AND food_id = ?', meal_food_params[:meal_id], meal_food_params[:food_id]).first
    if meal_food.destroy
      render json: meal_food, scope: { action: "remove" }
    end
  end

  private

  def meal_food_params
    params.permit(:meal_id, :food_id)
  end
end