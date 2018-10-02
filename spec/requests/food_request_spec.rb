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

  context "POST /api/v1/foods" do 
    it "successfully creates a new food" do 
      expect(Food.all.count).to eq(0)
      post "/api/v1/foods", :params => { :name => "cookie", :calories => 178 }

      expect(Food.all.count).to eq(1)
      expect(response).to have_http_status(200)
      
      new_food = JSON.parse(response.body, symbolize_names: true)

      expect(new_food).to have_key(:id)
      expect(new_food[:id]).to eq(1)
      expect(new_food).to have_key(:name)
      expect(new_food).to have_key(:calories)
    end

    it "returns 422 and 'Food not created' message when missing params" do
      
      post "/api/v1/foods", :params => { :name => "cookie" }
      expect(response).to have_http_status(422)

      result = JSON.parse(response.body, symbolize_names: true)
   
      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Validation failed: Calories can't be blank")
    end  
  end
end
