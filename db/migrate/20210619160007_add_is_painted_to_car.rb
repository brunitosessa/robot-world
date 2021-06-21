class AddIsPaintedToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :is_painted, :boolean, null: false, default: false
  end
end
