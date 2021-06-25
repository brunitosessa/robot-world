require 'rails_helper'

describe Part, type: :model do
    let!(:part_type) { FactoryBot.create(:part_type, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:car) {FactoryBot.create(:car, model:model, year: 2000)}

    subject { 
        described_class.new(
            part_type_id: part_type.id,
            defect: false,
            car_id: car.id
        )
    }

    # Active Records
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it 'is not valid without part_type_id' do
        subject.part_type_id = nil
        expect(subject).not_to be_valid
    end

    it 'is not valid without defect' do
        subject.defect = nil
        expect(subject).not_to be_valid
    end

    it 'is valid when not belongs to car' do
        expect(subject).not_to belong_to(:car)
    end

    it 'is valid when belongs to part_type' do
        expect(subject).to belong_to(:part_type)
    end

    # Database
    it { expect(subject).to have_db_index([:part_type_id, :car_id]).unique(:true)}
end