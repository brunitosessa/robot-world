class AddCarToPart < ActiveRecord::Migration[6.1]
  def change
    add_reference :parts, :car, null: true, foreign_key: {on_delete: :cascade}
  end
end
