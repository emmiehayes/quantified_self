#create default meals
Meal.create!(name: "Breakfast")
Meal.create!(name: "Lunch")
Meal.create!(name: "Dinner")
Meal.create!(name: "Snack")


#create example foods
Food.create!(name: "Banana", calories: 10)
Food.create!(name: "Waffle", calories: 10)
Food.create!(name: "Honey", calories: 10)
Food.create!(name: "Avocado", calories: 10)
Food.create!(name: "Tomato", calories: 10)
Food.create!(name: "Toast", calories: 10)
Food.create!(name: "Rice", calories: 10)
Food.create!(name: "Green Beans", calories: 10)
Food.create!(name: "Salmon", calories: 10)
Food.create!(name: "Grapes", calories: 10)
Food.create!(name: "Strawberries", calories: 10)
Food.create!(name: "Blueberries", calories: 10)

#add foods to meals
MEALFOOD_LIST = [
  [1, 1],
  [2, 1],
  [3, 1],
  [4, 2],
  [1, 2],
  [2, 2],
  [7, 3],
  [8, 3],
  [9, 3],
  [10, 4],
  [11, 4],
  [12, 4],
  [3, 4],
  [3, 4],
  [2, 2],
  [10, 1],
  [11, 1]
]
              
MEALFOOD_LIST.each do |food_id, meal_id|
  MealFood.create!(food_id: food_id, meal_id: meal_id)
end