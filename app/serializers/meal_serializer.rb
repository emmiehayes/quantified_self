class MealSerializer < ActiveModel::Serializer
  attributes :id, :name 
  has_many :foods, include: :all
end