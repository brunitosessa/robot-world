require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "events" do
    before do
      FactoryBot.create(:model, id:1, name: "Peugeot")
      FactoryBot.create(:car, id: 1, model_id:1, year: 2021, computer: Computer.new)
      FactoryBot.create(:order, id:1, car_id: 1)
      FactoryBot.create(:event, id:1, car_id: 1)
      FactoryBot.create(:event, id:2, model_id:1)
    end
    
    it 'get all events' do
      get '/api/v1/events'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'get all events by car' do
      get '/api/v1/events/car/1'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(1)
    end

    it 'get all events by type' do
      get '/api/v1/events/type/Sold'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(0)
    end

    it 'get all events by type' do
      get '/api/v1/events/model/1'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end
end
