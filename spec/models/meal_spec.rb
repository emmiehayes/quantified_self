require 'rails_helper'

RSpec.describe Meal, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "relationships" do
    it { should have_many(:meal_foods)}
    it { should have_many(:foods)}
  end
end
