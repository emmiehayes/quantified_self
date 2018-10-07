require 'rails_helper'

RSpec.describe MealFood, type: :model do
  
  context "relationships" do
    it { should belong_to :meal }
    it { should belong_to(:food).counter_cache(:meals_count) }
  end

  context "class methods" do
    it "find_relation" do
      orange = create(:food)
      snack = create(:meal)
      MealFood.create(meal_id: snack.id, food_id: orange.id)

      expect(MealFood.find_relation(snack.id, orange.id)).to eq(MealFood.first)
    end
  end
end
