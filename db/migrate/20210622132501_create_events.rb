class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :car, null: true, foreign_key: true
      t.references :order, null: true, foreign_key: true
      t.references :model, null: true, foreign_key: true

      t.timestamps
    end
  end
end
