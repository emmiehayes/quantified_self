Rails.application.routes.draw do

    namespace :api do
      namespace :v1 do
      get '/meals/:meal_id/foods', to: 'meals#show'
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index]
    end
  end
end
