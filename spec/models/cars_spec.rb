require 'rails_helper'

describe Car, type: :model do
    let!(:model) { FactoryBot.create(:model, name: "Peugeot")}
    let!(:part_type) { FactoryBot.create(:part_type, name: 'Chasis', assembly_line: "Basic_Structure")}
    let!(:part) {FactoryBot.create(:part, part_type_id: part_type.id, defect: false)}

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
        should belong_to(:model)
    end

    #VER!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    #it 'is not valid with repeated parts types' do
     #   expected = expect do
     #       subject << part
     #       subject << part
     #   end

     #   expected.to_not be_valid
    #end
end
