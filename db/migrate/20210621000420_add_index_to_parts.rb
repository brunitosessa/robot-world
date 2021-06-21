class AddIndexToParts < ActiveRecord::Migration[6.1]
  def change
    add_index :parts, [:part_type_id, :car_id], unique: true
  end
end
