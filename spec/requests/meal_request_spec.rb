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
end