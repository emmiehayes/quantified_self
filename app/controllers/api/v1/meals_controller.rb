class Api::V1::MealsController < ApplicationController
  before_action :set_meal, only:[:show]

  swagger_controller :meals, 'Meals'

  swagger_api :index do
    summary 'Fetch all meals'
    response :ok
  end

   swagger_api :show do
    summary 'Fetch a single meal by passing the meal id'
    param :path, :id, :integer, :required, "Meal Id"
    response :ok
    response :not_found
  end

  def index
    render json: Meal.all
  end

  def show
    render json: @meal
  end

  private 

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
