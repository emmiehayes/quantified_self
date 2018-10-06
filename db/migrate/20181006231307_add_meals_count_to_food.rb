class AddMealsCountToFood < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :meals_count, :integer, default: 0
  end
end
