class RobotGuard
    # Singleton Class
    @instance = new

    private_class_method :new

    def self.instance
        @instance
    end

    ###################
    ## INSTANCE METHODS
    ###################

    def transfer_stock_to_store
        # Get all warehouse cars
        warehouse_cars = Car.where('location = ?', 'warehouse').where('status = ?', 'complete')

        # Cars with no defects
        defectives, non_defectives = warehouse_cars.partition {|c| c.computer.has_defects? }

        # Move non defectives to store
        move_cars(non_defectives)

        # Sends Slack messages
        # Add event
        handle_defectives(defectives)
        
    end

    # Instance method that move cars to Store
    # Receives list of cars to be moved
    def move_cars(non_defectives)
        non_defectives.each do |car|
            car.location = 'store'
            car.save
            # Add to events
            car.events << Event.new(name: "Moved to Store")
        end
    end

    def handle_defectives(defectives)
        defectives.each do |car|
            car.events << Event.new(name: "Not moved because defective")
        end
    end
end