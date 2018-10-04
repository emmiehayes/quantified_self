class MealFoodSerializer < ActiveModel::Serializer
  attributes :message

  def message 
    if scope[:action] == "create"
      "Successfully added #{food_name} to #{meal_name}"
    elsif scope[:action] == "remove"
      "Successfully removed #{food_name} from #{meal_name}"
    end
  end

  def food_name
    Food.where(id: object.food_id).first.name
  end 

  def meal_name
    Meal.where(id: object.meal_id).first.name
  end
end