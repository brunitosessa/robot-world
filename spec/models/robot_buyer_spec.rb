require 'rails_helper'

describe RobotBuyer, type: :model do
    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:model_2) { FactoryBot.create(:model, name: "Renault")}
    let!(:car) {FactoryBot.create(:car, id:1, model:model, year: 2000)}
    let!(:car2) {FactoryBot.create(:car, id:2, model:model_2, year: 2000)}
    let!(:order) {FactoryBot.create(:order, car_id:2)}


    it '.buy_car has to buy one car' do
        car.location = 'store'
        car.status = 'complete'
        car.save
        expect { RobotBuyer.buy_car(model) }.to change { Car.check_store_stock(model) }.from(1).to(0)
    end

    it '.change_order has to change a car from order' do
        car.location = "store"
        car.status = "complete"
        car2.location = "sold"
        car2.status = "sold"
        car.save
        car2.save

        expect { RobotBuyer.change_order(order.id, model) }.to change { order.reload.car_id }.from(2).to(1)
        .and change { Car.check_store_stock(model) }.from(1).to(0)
        .and change { car.reload.location }.from("store").to("sold")
        .and change { car2.reload.location }.from("sold").to("store")
    end
end