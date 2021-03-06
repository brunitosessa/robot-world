require 'utilities'

class RobotBuilder
    extend Utilities

    ###################
    ## CLASS METHODS
    ###################

    # Class method that starts building cars
    # Parameter is the quantity of cars to build. If none 1 is default.
    def self.start_building(ammount = 1)
        (1..ammount).each { self.create_car }
    end

    # Class method that creates a complete car
    def self.create_car

        # Create Car
        car = Car.new
        
        # Randomly generate Car data
        car.model = random_model
        car.year = Time.current.year
        car.price = random_price
        car.cost_price = random_cost_price

        # Create Random basic parts
        basic_parts = random_parts_1

        # Create Random electronic parts
        electronic_parts = random_parts_2

        # Create Car Factory
        car_factory = CarFactory.new(car)
    

        # Run 1th line of car production
        car_factory.basic_structure(basic_parts)

        # Run 2nd line of car production
        car_factory.electronic_devices(electronic_parts, Computer.new)
        # Run 3th line of car production
        car_factory.painting_and_final_details

        #returns complete car
        car = car_factory.car
        car.save
    end
end