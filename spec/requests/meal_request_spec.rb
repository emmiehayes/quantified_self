require "rails_helper"

describe "Meals API" do
  context "GET /api/v1/meals" do
    it "returns a list of foods" do
      create_list(:meal, 3)

      get "/api/v1/meals"
      expect(response).to be_successful

      meals = JSON.parse(response.body, symbolize_names: true)
      meal = meals.first

      expect(Meal.all.count).to eq(3)
      expect(meal).to have_key(:id)
      expect(meal).to have_key(:name)
    end
  end
end