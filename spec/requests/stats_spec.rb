require 'rails_helper'

RSpec.describe "Stats", type: :request do
  describe "stats" do
    it 'get all stats' do
      get '/api/v1/stats/daily'
      expect(response).to have_http_status(:success)
    end
  end
end
