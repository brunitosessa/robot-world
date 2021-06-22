class AddComputerToCar < ActiveRecord::Migration[6.1]
  def change
    add_reference :cars, :computer, null: true, foreign_key: true
  end
end
