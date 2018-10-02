class Api::V1::FoodsController < ApplicationController
  
  swagger_controller :foods, 'Foods'
  
  swagger_api :index do
    summary 'Fetch all foods'
    response :ok
  end

  swagger_api :show do
    summary 'Fetch a single food by passing the food id'
    param :path, :id, :integer, :required, "Food Id"
    response :ok
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new ood"
    param :form, :name, :string, :required, "Food Name"
    param :form, :calories, :integer, :required, "Total Calories"
    response :ok
    response :unprocessable_entity
  end

  swagger_api :update do
    summary "Updates an existing food"
    param :path, :id, :integer, :required, "Food Id"
    param :form, :name, :string, :optional, "Food Name"
    param :form, :calories, :integer, :optional, "Total Calories"
    response :ok
    response :unprocessable_entity
  end

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create 
    render json: Food.create!(food_params)
  end

  def update
    @food = Food.find(params[:id])
    render json: @food if @food.update!(food_params)
  end

  private 

  def food_params
    params.permit(:name, :calories)
  end
end
