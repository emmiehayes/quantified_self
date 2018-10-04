class Api::V1::MealFoodsController < ApplicationController

  def create
    @meal_food = MealFood.create(meal_food_params)
    if @meal_food.save!
     render json: @meal_food, serializer: MealFoodSerializer
    end
  end

  private

  def meal_food_params
    params.permit(:meal_id, :food_id)
  end
end