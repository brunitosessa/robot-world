require 'rails_helper'

RSpec.describe "Cars", type: :request do
  describe "cars" do
    before do
      FactoryBot.create(:model, id:1, name: "Peugeot")
      FactoryBot.create(:car, id: 1, model_id:1, year: 2021, computer: Computer.new)
      FactoryBot.create(:car, id: 2, model_id:1, year: 2021, computer: Computer.new)
    end


    it 'get all cars' do
      get '/api/v1/cars'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'get one car by id' do
      get '/api/v1/cars/1'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(
        {
          "id"=>1,
          "defective_parts"=>false,
          "location"=>"factory", 
          "model" => {
            "id"=>1, 
            "name"=>"Peugeot"
          }, 
          "parts"=>[], 
          "status"=>"new", 
          "year"=>2021
        }
      )
    end

    it 'get list of defective cars' do
      get '/api/v1/cars/defectives'

      expect(response).to have_http_status(:success)
    end

  end

end
