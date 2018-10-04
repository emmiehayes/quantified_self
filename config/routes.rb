Rails.application.routes.draw do

    namespace :api do
      namespace :v1 do
      get '/meals/:meal_id/foods', to: 'meals#show'
      post '/meals/:meal_id/foods/:food_id', to: 'meal_foods#create'
      delete '/meals/:meal_id/foods/:food_id', to: 'meal_foods#destroy'


      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index]
    end
  end
end
