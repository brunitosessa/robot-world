require 'utilities'

class RobotBuilder
    include Utilities

    # Singleton Class
    @instance = new

    private_class_method :new

    def self.instance
        @instance
    end

    def create_car
        # Create Car
        car = Car.new
        
        # Randomly generate Car data
        car.model = random_model
        car.year = random_year
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
        car_factory.electronic_devices(electronic_parts)
        # Run 3th line of car production
        car_factory.painting_and_final_details()

        #returns complete car
        car = car_factory.car
        car.save


        #ESTO NO IRIA, ES PARA TESTING
        if defects = car.has_defects?
            puts "AUTO CON FALLAS en #{defects}"
        else
            puts "AUTO SIN FALLAS"
        end
    end

    def change_order

    end
end