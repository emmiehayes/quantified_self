require "rails_helper"

describe "Foods API" do
  context "GET /api/v1/foods" do
    it "returns a list of foods" do
      create_list(:food, 3)

      get "/api/v1/foods.json"
      expect(response).to be_successful

      foods = JSON.parse(response.body, symbolize_names: true)
      food = foods.first

      expect(foods.count).to eq(3)
      expect(food).to have_key(:id)
      expect(food).to have_key(:name)
      expect(food).to have_key(:calories)
    end
  end

  context "GET /api/v1/foods/:id" do
    it "successfully returns single food" do
      create_list(:food, 3)
      food = Food.first

      get "/api/v1/foods/#{food.id}.json"
      expect(response).to be_successful

      food_1 = JSON.parse(response.body, symbolize_names: true)

      expect(food_1[:id]).to eq(food.id)
      expect(food_1).to have_key(:name)
      expect(food_1).to have_key(:calories)
    end

    it "returns 404 and 'Couldn't find Food' message when id requested does not exist" do
      non_existing_food_id = 1000

      get "/api/v1/foods/#{non_existing_food_id}.json"
      expect(response).to have_http_status(404)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Couldn't find Food with 'id'=1000")
    end
  end
end
