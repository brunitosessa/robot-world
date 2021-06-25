require 'rails_helper'

describe RobotGuard, type: :model do
    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:car) {FactoryBot.create(:car, model: model, year: 2000, computer: Computer.new)}
    let!(:part_type) { FactoryBot.create(:part_type, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:defective_part) {FactoryBot.create(:part, part_type_id: part_type.id, defect: true)}
    let!(:part) {FactoryBot.create(:part, part_type_id: part_type.id, defect: false)}


    it '.self.remove_defectives has to remove defectives from warehouse' do
        car.parts << defective_part
        car.location = 'warehouse'
        car.save
        expect { RobotGuard.remove_defectives }.to change(Car, :count).by(-1)
    end

    it '.self.move_cars has to move cars to store' do
        car.location = 'warehouse'
        car.save
        expect { RobotGuard.send(:move_cars, Car.all) }.to change { car.reload.location }.to("store")
    end


    # This 2 tests send the slack notification, and I don't like it, because they receive a link with
    # defective cars and that link has different defectives than in DB, because rspec uses a sqlite DB
    
    #it 'self.transfer_stock_to_store has to move non defective cars to store' do
    #    car.parts << part
    #    car.location = 'warehouse'
    #    car.save
    #    expect { RobotGuard.transfer_stock_to_store }.to change{ car.reload.location }.from('warehouse').to('store')
    #end

    #it 'self.send_defectives_slack_message has to send slack and receive ok' do
    #    response = RobotGuard.send(:send_defectives_slack_message, Car.all)
    #    expect(response).to eq('ok') 
    #end
end