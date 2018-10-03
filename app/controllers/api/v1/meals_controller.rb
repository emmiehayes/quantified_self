class Api::V1::MealsController < ApplicationController

  swagger_controller :meals, 'Meals'

  swagger_api :index do
    summary 'Fetch all meals'
    response :ok
  end

  def index
    render json: Meal.all
  end
end
