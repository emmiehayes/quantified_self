require 'rails_helper'

RSpec.describe MealFood, type: :model do
  it { should belong_to :meal }
  it { should belong_to(:food).counter_cache(:meals_count) }
end
