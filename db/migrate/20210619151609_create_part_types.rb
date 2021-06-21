class CreatePartTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :part_types do |t|
      t.string :name
      t.string :assembly_line
    end
  end
end
