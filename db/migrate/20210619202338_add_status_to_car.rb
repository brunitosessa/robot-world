class AddStatusToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :status, :string, null: false, default: :new
  end
end
