class FavoriteFoodsPresenter

  def favorite_foods
    if Food.times_eaten.empty?
      { 
        message: "For the love of food, eat something more than once." 
      }
    else
      Food.times_eaten.map do |value|
      {
        timesEaten: value, 
        foods: populate_foods(value)
      }
      end
    end
  end
  
  private 
  
  def populate_foods(value)
    Food.all.map do |food|
      if food.meals_count == value
        {
          id: food.id,
          name: food.name,
          calories: food.calories,
          mealsWhenEaten: food.meals_when_eaten
        }
      end
    end.compact
  end
end