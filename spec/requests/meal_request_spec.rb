require "rails_helper"

describe "Meals API" do
  context "GET /api/v1/meals" do
    it "returns a list of foods" do
    create(:meal, :with_foods)
    
      get "/api/v1/meals"
      expect(response).to be_successful

      meals = JSON.parse(response.body, symbolize_names: true)
      meal = meals.first

      expect(Meal.all.count).to eq(1)
      expect(meal).to have_key(:id)
      expect(meal).to have_key(:name)
      expect(meal).to have_key(:foods)
      expect(meal[:foods]).to eq([{:id=>1, :name=>"MyString", :calories=>1}, {:id=>2, :name=>"MyString", :calories=>1}])
    end
  end

  context "GET /api/v1/meals/:meal_id/foods" do
    it "successfully returns single meal with foods" do
      2.times do 
        create(:meal, :with_foods)
      end
  
      meal = Meal.first

      get "/api/v1/meals/#{meal.id}/foods.json"
      expect(response).to be_successful
      meal_1 = JSON.parse(response.body, symbolize_names: true)

      expect(meal_1[:id]).to eq(meal.id)
      expect(meal_1).to have_key(:name)
      expect(meal_1).to have_key(:foods)
      expect(meal_1[:foods].count).to eq(2)
    end

    it "returns 404 with message when id requested does not exist" do
      non_existing_meal_id = 1000

      get "/api/v1/meals/#{non_existing_meal_id}/foods.json"
      expect(response).to have_http_status(404)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Couldn't find Meal with 'id'=1000")
    end
  end

  context "POST /api/v1/meals/:meal_id/foods/:id" do 
    it "successfully adds a food to a meal" do 
      food = create(:food)
      meal = create(:meal)
      expect(meal.foods.count).to eq(0)

      post "/api/v1/meals/#{meal.id}/foods/#{food.id}"

      expect(meal.foods.count).to eq(1)
      expect(response).to have_http_status(200)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Successfully added #{food.name} to #{meal.name}")
    end

    it "returns 422 when an invalid food id is added to a meal" do
      invalid_food_id = 1000
      meal = create(:meal)

      post "/api/v1/meals/#{meal.id}/foods/#{invalid_food_id}"
      expect(response).to have_http_status(422)

      result = JSON.parse(response.body, symbolize_names: true)
   
      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Validation failed: Food must exist")
    end  
  end

  context "DELETE /api/v1/meals/:meal_id/foods/:id" do 
    it "successfully deletes an existing food from a meal" do 
      meal = create(:meal, :with_foods)
      food = meal.foods.first
      
      expect(meal.foods.count).to eq(2)
      delete "/api/v1/meals/#{meal.id}/foods/#{food.id}"

      expect(meal.foods.count).to eq(1)
      expect(response).to have_http_status(200)
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Successfully removed #{food.name} from #{meal.name}")
    end

    it "returns 404 with message when food to delete from meal does not exist" do
      non_existing_food_id = 1000

      delete "/api/v1/foods/#{non_existing_food_id}.json"
      expect(response).to have_http_status(404)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Couldn't find Food with 'id'=1000")
    end
  end
end