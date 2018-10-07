require "rails_helper"

describe "Favorite Foods API" do
  context "GET /api/v1/favorite_foods" do
    it "returns 3 highest timesEaten values, excluding 1" do
      banana = Food.create(name: "Banana", calories: 110)
      avocado = Food.create(name: "Avocado", calories: 130)
      bread = Food.create(name: "Bread", calories: 40)
      honey = Food.create(name: "Honey", calories: 60)

      bfast = Meal.create(name: "Breakfast")
      lunch = Meal.create(name: "Lunch")
      snack = Meal.create(name: "Snack")

      MealFood.create(meal_id: bfast.id, food_id: banana.id)
      MealFood.create(meal_id: lunch.id, food_id: banana.id)
      MealFood.create(meal_id: snack.id, food_id: banana.id)
      MealFood.create(meal_id: bfast.id, food_id: bread.id)
      MealFood.create(meal_id: lunch.id, food_id: bread.id)
      MealFood.create(meal_id: bfast.id, food_id: honey.id)
      MealFood.create(meal_id: snack.id, food_id: honey.id)
      MealFood.create(meal_id: lunch.id, food_id: avocado.id)
      
      get "/api/v1/favorite_foods"

      expect(response).to be_successful

      array = JSON.parse(response.body, symbolize_names: true)
  
      food_1 = array.first[:foods][0]
      food_2 = array.second[:foods][0]
      food_3 = array.second[:foods][1]

      expect(array[0][:timesEaten]).to eq(banana.meals.count)
      expect(array[1][:timesEaten]).to eq(bread.meals.count)
      expect(array[1][:timesEaten]).to eq(honey.meals.count)
  
      expect(food_1[:id]).to eq(banana.id)
      expect(food_1[:name]).to eq(banana.name)
      expect(food_1[:calories]).to eq(banana.calories)
      expect(food_1[:mealsWhenEaten]).to include(banana.meals[0].name)
      expect(food_1[:mealsWhenEaten]).to include(banana.meals[1].name)
      expect(food_1[:mealsWhenEaten]).to include(banana.meals[2].name)

      expect(food_2[:id]).to eq(bread.id)
      expect(food_2[:name]).to eq(bread.name)
      expect(food_2[:calories]).to eq(bread.calories)
      expect(food_2[:mealsWhenEaten]).to include(bread.meals[0].name)
      expect(food_2[:mealsWhenEaten]).to include(bread.meals[1].name)

      expect(food_3[:id]).to eq(honey.id)
      expect(food_3[:name]).to eq(honey.name)
      expect(food_3[:calories]).to eq(honey.calories)
      expect(food_3[:mealsWhenEaten]).to include(honey.meals[0].name)
      expect(food_3[:mealsWhenEaten]).to include(honey.meals[1].name)
    end
    
    it "returns message if no food has been consumed more than once" do
      meal = create(:meal, :with_foods)

      get "/api/v1/favorite_foods"
      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:message]).to eq("For the love of food, eat something more than once.")
    end
  end
end
