class MealFoodSerializer < ActiveModel::Serializer
  attributes :message

  def message 
    "Successfully added #{food_name} to #{meal_name}"
  end

  def food_name
    Food.where(id: object.food_id).first.name
  end 

  def meal_name
    Meal.where(id: object.meal_id).first.name
  end
end