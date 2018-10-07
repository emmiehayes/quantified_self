class MealFood < ApplicationRecord
  belongs_to :food, counter_cache: :meals_count
  belongs_to :meal

  def self.find_relation(meal_id, food_id)
    where('meal_id = ? AND food_id = ?', meal_id, food_id).first
  end
end
