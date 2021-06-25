require 'rails_helper'

describe RobotBuilder, type: :model do
    let!(:part_type_1) { FactoryBot.create(:part_type, id:1, name: 'W1', assembly_line: "Basic_Structure")}
    let!(:part_type_2) { FactoryBot.create(:part_type, id:2, name: 'W2', assembly_line: "Basic_Structure")}
    let!(:part_type_3) { FactoryBot.create(:part_type, id:3, name: 'W3', assembly_line: "Basic_Structure")}
    let!(:part_type_4) { FactoryBot.create(:part_type, id:4, name: 'W4', assembly_line: "Basic_Structure")}
    let!(:part_type_5) { FactoryBot.create(:part_type, id:5, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:part_type_6) { FactoryBot.create(:part_type, id:6, name: 'Engine', assembly_line: "Basic_Structure")}
    let!(:part_type_7) { FactoryBot.create(:part_type, id:7, name: 'Seat1', assembly_line: "Basic_Structure")}
    let!(:part_type_8) { FactoryBot.create(:part_type, id:8, name: 'Seat2', assembly_line: "Basic_Structure")}
    let!(:part_type_9) { FactoryBot.create(:part_type, id:9, name: 'laser', assembly_line: "Electronic_Devices")}

    let!(:model) { FactoryBot.create(:model, id:1, name: "Peugeot")}
    let!(:model) { FactoryBot.create(:model, id:2, name: "Renault")}
    let!(:model) { FactoryBot.create(:model, id:3, name: "Fiat")}
    let!(:model) { FactoryBot.create(:model, id:4, name: "Hyundai")}
    let!(:model) { FactoryBot.create(:model, id:5, name: "Ferrari")}
    let!(:model) { FactoryBot.create(:model, id:6, name: "Mustang")}
    let!(:model) { FactoryBot.create(:model, id:7, name: "Honda")}
    let!(:model) { FactoryBot.create(:model, id:8, name: "Porsche")}
    let!(:model) { FactoryBot.create(:model, id:9, name: "Kia")}
    let!(:model) { FactoryBot.create(:model, id:10, name: "Ford")}

    # Scope
    it '.start_building has to build one car' do
        expect { RobotBuilder.create_car }.to change(Car, :count).from(0).to(1)
    end

    it '.start_building has to build several cars' do
        expect { RobotBuilder.start_building(10) }.to change(Car, :count).from(0).to(10)
    end
end