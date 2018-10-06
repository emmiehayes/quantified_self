class MealFood < ApplicationRecord
  belongs_to :food, counter_cache: :meals_count
  belongs_to :meal
end
