FactoryBot.define do

  # user factory without associated stories
  factory :meal do
    name { "MyString" }
    # user attributes

    trait :with_foods do
      after(:create) do |meal|
        create_list :food, 2, meals: [meal]
      end
    end
  end
end