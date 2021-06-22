# Every minute build 10 cars
every 1.minute do
    runner 'RobotBuilder.start_building(ammount=10)'
end

# Every 30 minuts RobotGuard send non defective cars to store
# And send Slack message and save event on defective cars
every 30.minutes do
    runner 'RobotGuard.transfer_stock_to_store'
end

# At the beggin of day, erase all cars
every :day do
    runner 'Car.delete_all'
end