class AddLocationToCar < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :location, :string, null: false, default: :factory
  end
end
