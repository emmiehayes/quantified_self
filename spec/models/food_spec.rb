require 'rails_helper'

RSpec.describe Food, type: :model do
  
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:calories) }
  end

  context "relationships" do
    it { should have_many(:meal_foods)}
    it { should have_many(:meals)}
  end

  context "instance methods" do
    it "meals_when_eaten" do 
      orange = create(:food)
      snack = create(:meal)
      MealFood.create(meal_id: snack.id, food_id: orange.id)

      expect(orange.meals_when_eaten.first).to eq("MyString")
    end
  end

  context "class methods" do
    it "times_eaten" do
      create_list(:food, 10)
      create_list(:meal, 4)
      MealFood.create(meal_id: Meal.first.id, food_id: Food.first.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.first.id)
      MealFood.create(meal_id: Meal.third.id, food_id: Food.first.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.first.id)
      MealFood.create(meal_id: Meal.third.id, food_id: Food.first.id)
      MealFood.create(meal_id: Meal.first.id, food_id: Food.second.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.second.id)
      MealFood.create(meal_id: Meal.first.id, food_id: Food.second.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.second.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.third.id)
      MealFood.create(meal_id: Meal.first.id, food_id: Food.third.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.third.id)
      MealFood.create(meal_id: Meal.first.id, food_id: Food.last.id)
      MealFood.create(meal_id: Meal.second.id, food_id: Food.last.id)

      expect(Food.times_eaten).to eq([5, 4, 3])
    end
  end
end
