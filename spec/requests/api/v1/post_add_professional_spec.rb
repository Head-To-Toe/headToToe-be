require 'rails_helper'

RSpec.describe 'POST /add_professional' do
  context 'happy path' do
    it 'returns the correct json structure' do
      body = {
          first_name: "FirstName",
          last_name: "LastName",
          street: "123 Street",
          unit: "123 Unit",
          city: "Denver",
          state: "Colorado",
          zip: "12345",
          phone: "1234567890",
          profession: "doctor",
          insurance: "BigMoney, OtherBigMoney",
          specialties: "Stuff, Things, Problems"
      }
  
      post '/api/v1/add_professional', 
      params: body.to_json, 
      headers: { 
        "Content-Type": "application/json", 
        "Accept": "application/json",
        "api_key": "aidanisthebest"
      }
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end