class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.string :type
      t.boolean :defect
    end
  end
end
