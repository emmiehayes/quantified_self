class Food < ApplicationRecord
  validates_presence_of :name, :calories
  has_many :meal_foods
  has_many :meals, through: :meal_foods

  def self.times_eaten
    order('meals_count DESC')
    .distinct
    .where('meals_count > 1')
    .limit(3)
    .pluck(:meals_count)
  end

  def meals_when_eaten
    meals.distinct
    .pluck(:name)
  end
end

