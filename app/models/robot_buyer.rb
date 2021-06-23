require 'utilities'

class RobotBuyer
    
    extend Utilities

    ###################
    ## CLASS METHODS
    ###################

    def self.start_buying(max=1)
        (1..(1..max).to_a.sample).each { self.buy_car }
    end

    # Method for buying a random model car
    def self.buy_car(model = random_model)
        # If there is stock in store, returns first Car to sell of that model
        if (car_to_sell = Car.get_car_to_sell(model))
            # Sells the car
            if car_to_sell.sell
                if car_to_sell.order = Order.new
                    car_to_sell.save
                end
            else
                puts "Error selling car"
            end

            # Add to events
            car_to_sell.events << Event.new(name: "Sold", order: car_to_sell.order)
        # No stock of car model
        else
            # Add to events
            model.events << Event.new(name: "Missing Stock")
        end
    end

    def self.change_order(order_id, model = random_model)
        # Check if order exists
        if (order = Order.exists?(order_id) && Order.find(order_id))
            #Check if new model is different from actual model
            unless (order.car.model == model)
                # If there is stock on store of new car model
                if (new_car = Car.get_car_to_sell(model))
                    # Car to return
                    old_car = order.car

                    # If no problem with return, save
                    if old_car.return
                        # Mark new car as sold
                        if new_car.sell
                            # Save new car into order
                            new_car.order = order

                            #Save new and old cars
                            new_car.save
                            old_car.save

                            # Add to events
                            order.events << Event.new(name: "Order changed", car:old_car)
                            new_car.events << Event.new(name: "Sold", order: order)    
                        end
                    else
                        puts "Error returning car"
                    end
                # No stock of new car model
                else
                    # Add to events
                    model.events << Event.new(name: "Missing Stock")
                end
            # New model equal to old model
            else
                puts "The order already has this model"
            end
        # Wrong Order id
        else
            puts "Incorrect Order Id"
        end
    end
end