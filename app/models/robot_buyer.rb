require 'utilities'

class RobotBuyer
    include Utilities

    # Singleton Class
    @instance = new

    private_class_method :new

    def self.instance
        @instance
    end

    ###################
    ## INSTANCE METHODS
    ###################

    # Method for buying a random model car
    def buy_car(model = random_model)
        
        # If there is stock in store, returns first Car to sell of that model
        if (car_to_sell = Car.get_car_to_sell(model))
            # Sells the car
            car_to_sell.sell
            car_to_sell.save!

            #Create the order
            order = Order.create!(car: car_to_sell)

            # Add to events
            car_to_sell.events << Event.new(name: "Sold", order: order)
        else
            # Add to events
            model.events << Event.new(name: "Missing Stock")
        end
    end

    def change_order(order_id, model = random_model)
        # If there is stock on store of new model car
        if (new_car = Car.get_car_to_sell(model))
            # Get the order
            order = Order.find(order_id)

            # Return Car
            old_car = order.car
            old_car.return
            old_car.save!

            # Mark new car as sold
            new_car.sell
            new_car.save!

            # Add to events
            new_car.events << Event.new(name: "Sold", order: order)    

            # Change order car with new car
            order.car = new_car
            order.save!

            # Add to events
            order.events << Event.new(name: "Order changed", car:old_car)
        else
            # Add to events
            model.events << Event.new(name: "Missing Stock")
        end
    end
end