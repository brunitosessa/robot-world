class CarFactory
    attr_reader :car

    def initialize(car=nil)
        if (car)
            @car = car
        else
            reset
        end
    end

    # Give us an empty car in the factory
    def reset
        @car = Car.new
    end
    

    # Calls 1th line of car production
    def basic_structure(basic_parts)
        @car.parts << basic_parts
        @car.status = "basic_parts_complete"
        # Add to events
        @car.events << Event.new(name: "Basic Structure Done")
        @car.save
    end

    # Calls 2nd line of car production
    def electronic_devices(electronic_parts, computer)
        @car.parts << electronic_parts
        @car.computer = computer
        @car.status = "electronic_devices"
        # Add to events
        @car.events << Event.new(name: "Electronic Devices Done")
        @car.save
    end

    # Call 3th line of car production
    def painting_and_final_details
        @car.is_painted = true
        @car.location = "warehouse"
        @car.status = "complete"
        # Add to events
        @car.events << Event.new(name: "Complete in Warehouse")
        @car.save
    end

    #Returns complete car
    def Car
        car = @car
        reset
        car
    end
end