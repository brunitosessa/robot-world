# Every minute build 10 cars
every 1.minute do
    runner 'RobotBuilder.start_building(ammount=10)'
end

# Every minute buy (max of 10)
every 1.minute do
    runner 'RobotBuyer.start_buying(max=10)'
end

# Every 30 minuts RobotGuard send non defective cars to store
# And send Slack message and save event on defective cars
every 1.minutes do
    runner 'RobotGuard.transfer_stock_to_store'
end

# At the beggin of day, erase all cars
every 50.minute do
    runner 'RobotGuard.remove_defectives'
end