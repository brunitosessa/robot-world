require 'utilities'

class RobotBuyer
    include Utilities

    # Singleton Class
    @instance = new

    private_class_method :new

    def self.instance
        @instance
    end

    def buy_car
        model = random_model
        
        # If there is stock in store, returns first Car to sell of that model
        if (car_to_sell = Car.get_car_to_sell(model.name))
            # Sells the car
            if car_to_sell.sell
                car_to_sell.save

                #Create the order
                order = Order.create(car: car_to_sell)
            end
        else
            puts "No hay Autos modelo #{model.name}"
        end
    end

    def return_car

    end

    def change_order
        new_model = "Suzuki"
        order_id = 1

        rb = RobotBuildes.new
        rb.change_order
    end
end