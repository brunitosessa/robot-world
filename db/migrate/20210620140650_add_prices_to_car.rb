class AddPricesToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :price, :float
    add_column :cars, :cost_price, :float
  end
end
