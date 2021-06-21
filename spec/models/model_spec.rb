require 'rails_helper'

describe Model, type: :model do
    subject { 
        described_class.new(
            name: "Peugeot"
        )
     } 

     # BEGIN OF TESTS

     it 'is valid with valid attributes' do
         expect(subject).to be_valid
     end

     it 'is not valid without name' do
        subject.name = nil
        expect(subject).to_not be_valid
     end 

    it 'is valid when has many cars' do
        should have_many(:cars)
    end
end
  