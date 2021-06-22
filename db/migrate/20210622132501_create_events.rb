class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :car, null: true, foreign_key: {on_delete: :cascade}
      t.references :order, null: true, foreign_key: {on_delete: :cascade}
      t.references :model, null: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
