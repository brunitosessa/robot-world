class AddPartTypeToPart < ActiveRecord::Migration[6.1]
  def change
    add_reference :parts, :part_type, null: false, foreign_key: true
  end
end
