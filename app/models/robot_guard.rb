class RobotGuard
    # Singleton Class
    @instance = new

    private_class_method :new

    def self.instance
        @instance
    end


    def transfer_stock_to_store
        # Get all warehouse cars
        warehouse_cars = Car.where('location = ?', 'warehouse').where('status = ?', 'complete')

        # Select only cars withno defects
        send_to_store = warehouse_cars.select {|c| !c.has_defects? }

        # Move them to store
        send_to_store.each do |car|
            car.location = 'store'
            car.save
        end
    end
end