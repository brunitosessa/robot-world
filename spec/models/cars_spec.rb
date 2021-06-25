require 'rails_helper'

describe Car, type: :model do
    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:part_type) { FactoryBot.create(:part_type, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:part_type_2) { FactoryBot.create(:part_type, name: 'Engine', assembly_line: "Basic_Structure")}
    let!(:part) {FactoryBot.create(:part, part_type_id: part_type.id, defect: false)}
    let!(:defective_part) {FactoryBot.create(:part, part_type_id: part_type_2.id, defect: true)}

    subject {
        described_class.new(
            model: model,
            year: 1999
        )
    }

    # BEGIN OF TESTS

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it 'is not valid without model' do
        subject.model = nil
        expect(subject).to_not be_valid
    end

    it 'is not valid without year' do
        subject.year = nil
        expect(subject).to_not be_valid
    end

    it 'is valid when belongs to model' do 
        expect(subject).to belong_to(:model)
    end

    it 'is valid when has_many parts' do
        expect(subject).to have_many(:parts)
    end

    it 'is valid when not has a computer' do
        expect(subject).not_to belong_to(:computer)
    end

    # Scopes

    it '.sell change location and status of car' do
        subject.status = "complete"
        subject.location = "store"
        subject.sell
        expect(subject.status).to eq('sold')
    end

    it '.return change location and status of car' do
        subject.status = "sold"
        subject.location = "sold"
        subject.return
        expect(subject.status).to eq('complete')
    end

    it '.is_complete? return car line production' do
        subject.status = "Basic_Structure"
        expect(subject.is_complete?).to eq("Basic_Structure")
    end

    it '.self.in_store return cars in store' do
        subject.location = "store"
        subject.save
        expect(Car.in_store.first).to eq(subject)
    end

    it '.self.in_warehouse return cars in warehouse' do
        subject.location = "warehouse"
        subject.save
        expect(Car.in_warehouse.first).to eq(subject)
    end

    it '.self.get_car_to_sell return car to sell' do
        subject.location = "store"
        subject.save
        expect(Car.get_car_to_sell(model)).to eq(subject)
    end

    it '.self.defective_cars return list of defective cars' do
        subject.location = "warehouse"
        subject.parts << defective_part
        subject.save
        expect(Car.defective_cars.first).to eq(subject)
    end
    
    it '.self.check_store_stock return store stock' do
        subject.location = "store"
        subject.save
        expect(Car.check_store_stock(model)).to eq(1)
    end
    
    it '.self.check_factory_stock return factory stock' do
        subject.location = "warehouse"
        subject.save
        expect(Car.check_factory_stock(model)).to eq(1)
    end
    
    
end
