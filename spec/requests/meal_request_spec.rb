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
end