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

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end
end
