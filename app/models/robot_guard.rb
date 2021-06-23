require 'utilities'

class RobotGuard

    extend Utilities

    ###################
    ## CLASS METHODS
    ###################

    # Class method that transfer non defective cars on factory to store
    # If defective cars, sends a Slack message and save that event
    def self.transfer_stock_to_store
        # Get all warehouse cars
        warehouse_cars = Car.where('location = ?', 'warehouse').where('status = ?', 'complete')

        # If warehouse is not empty
        if warehouse_cars.count > 0
            # Cars with no defects
            defectives, non_defectives = warehouse_cars.partition {|c| c.computer.has_defects? }

            # Move non defectives to store
            self.move_cars(non_defectives)

            #REMOVE DEFECTIVE CARS HERE

            # Sends Slack messages
            send_slack(url: https://slack.com/api/chat.postMessage, message="Probando desde Ruby padre")

            # Add event
            self.handle_defectives(defectives)
        end
        
    end

    # Instance method that move cars to Store
    # Receives list of cars to be moved
    def self.move_cars(non_defectives)
        non_defectives.each do |car|
            car.location = 'store'
            car.save
            # Add to events
            car.events << Event.new(name: "Moved to Store")
        end
    end

    def self.handle_defectives(defectives)
        defectives.each do |car|
            car.events << Event.new(name: "Not moved because defective")
        end
    end
end