class RobotGuard

    ###################
    ## CLASS METHODS
    ###################

    # Class method that transfer non defective cars on factory to store
    # If defective cars, sends a Slack message and save that event
    def self.transfer_stock_to_store
        # Get all warehouse cars
        warehouse_cars = Car.in_warehouse

        # If warehouse is not empty
        if warehouse_cars.count > 0
            # Cars with no defects
            defectives, non_defectives = warehouse_cars.partition {|c| c.computer.has_defects? }

            # Move non defectives to store
            self.move_cars(non_defectives)

            #Send Slack notification with quantity of defectives cars
            self.send_defectives_slack_message(defectives)
        end
        
    end

    def self.remove_defectives
        Car.defective_cars.destroy_all
    end 

    private

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

    # Private method that create and sends the slack message
    def self.send_defectives_slack_message(defectives)
        slack_message = SlackMessage.new
        slack_message.url = SLACK_URL
        slack_message.message = "Message from RobotGuard :robot_face:"
        slack_message.attachments = [
            {
                "title": ":warning: You have #{defectives.count} defective cars in the Warehouse :car:",
                "text": "<http://localhost:3000/api/v1/cars/defectives|Click here for more info!>"
            }
        ]
        slack_message.send
    end
end