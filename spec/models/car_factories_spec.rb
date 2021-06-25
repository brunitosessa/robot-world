require 'rails_helper'

describe CarFactory, type: :model do
    let!(:part_type_1) { FactoryBot.create(:part_type, name: 'W1', assembly_line: "Basic_Structure")}
    let!(:part_type_2) { FactoryBot.create(:part_type, name: 'W2', assembly_line: "Basic_Structure")}
    let!(:part_type_3) { FactoryBot.create(:part_type, name: 'W3', assembly_line: "Basic_Structure")}
    let!(:part_type_4) { FactoryBot.create(:part_type, name: 'W4', assembly_line: "Basic_Structure")}
    let!(:part_type_5) { FactoryBot.create(:part_type, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:part_type_6) { FactoryBot.create(:part_type, name: 'Engine', assembly_line: "Basic_Structure")}
    let!(:part_type_7) { FactoryBot.create(:part_type, name: 'Seat1', assembly_line: "Basic_Structure")}
    let!(:part_type_8) { FactoryBot.create(:part_type, name: 'Seat2', assembly_line: "Basic_Structure")}
    let!(:part_type_9) { FactoryBot.create(:part_type, name: 'laser', assembly_line: "Electronic_Devices")}

    let!(:part_1) {FactoryBot.create(:part, part_type_id: part_type_1.id, defect: false)}
    let!(:part_2) {FactoryBot.create(:part, part_type_id: part_type_2.id, defect: false)}
    let!(:part_3) {FactoryBot.create(:part, part_type_id: part_type_3.id, defect: false)}
    let!(:part_4) {FactoryBot.create(:part, part_type_id: part_type_4.id, defect: false)}
    let!(:part_5) {FactoryBot.create(:part, part_type_id: part_type_5.id, defect: false)}
    let!(:part_6) {FactoryBot.create(:part, part_type_id: part_type_6.id, defect: false)}
    let!(:part_7) {FactoryBot.create(:part, part_type_id: part_type_7.id, defect: false)}
    let!(:part_8) {FactoryBot.create(:part, part_type_id: part_type_8.id, defect: false)}
    let!(:part_9) {FactoryBot.create(:part, part_type_id: part_type_9.id, defect: false)}

    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:car) {FactoryBot.create(:car, model:model, year: 2000)}

    let!(:basic_parts) { Part.joins(:part_type).where("part_types.assembly_line = 'Basic_Structure'") }
    let!(:electronic_parts) { Part.joins(:part_type).where("part_types.assembly_line = 'Electronic_Devices'") }

    subject {
        described_class.new(
            car
        )
    }

    # Scopes

    it '.basic_structure run 1th line of production' do
        subject.basic_structure(basic_parts)
        expect(subject.car.status).to eq('Basic_Structure')
    end

    it '.electronic_devices run 2nd line of production' do
        subject.electronic_devices(electronic_parts, Computer.new)
        expect(subject.car.status).to eq('Electronic_Devices')
    end

    it '.painting_and_final_details run 3th line of production' do
        subject.painting_and_final_details
        expect(subject.car.status).to eq('complete')
        expect(subject.car.is_painted).to eq(true)
    end

    it '.parts_ok? return false is missing parts of line of production' do
        incomplete_parts = basic_parts.take(3)

        expect(subject.parts_ok?("Basic_Structure", incomplete_parts)).to eq(false)
        
    end
end 