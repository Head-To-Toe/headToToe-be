require 'rails_helper'

RSpec.describe 'PATCH /medical_professionals' do
  context 'happy path' do
    context 'doctor update' do
      it "updates record's vetted attribute from false to true" do
        doctor = create :doctor, vetted: false

        expect(doctor.vetted).to eq(false)

        body = {
            profession: 'doctor'
        }
    
        patch "/api/v1/medical_professionals/#{doctor.id}", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to be_successful
        expect(response.status).to eq(204)

        doctor = Doctor.first
        expect(doctor.vetted).to eq(true)
      end
    end

    context 'mental health professional update' do
      it "updates record's vetted attribute from false to true" do
        mhp    = create :mental_health_professional, vetted: false

        expect(mhp.vetted).to eq(false)

        body = {
            profession: 'mhp'
        }
    
        patch "/api/v1/medical_professionals/#{mhp.id}", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to be_successful
        expect(response.status).to eq(204)

        mhp = MentalHealthProfessional.first
        expect(mhp.vetted).to eq(true)
      end
    end
  end

  context 'sad path' do
    context 'failed status codes' do
      it "returns 401 if api_key is not passed as header" do
        doctor = create :doctor, vetted: false

        expect(doctor.vetted).to eq(false)

        body = {
            profession: 'doctor'
        }
    
        patch "/api/v1/medical_professionals/#{doctor.id}", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json"
        }
        
        expect(response).to_not be_successful
        expect(response.status).to eq(401)
      end

      it "returns 404 if no doctor is found from passed id" do
        body = {
            profession: 'doctor'
        }
    
        patch "/api/v1/medical_professionals/1", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
      end

      it "returns 404 if no mental health professional is found from passed id" do
        body = {
            profession: 'mhp'
        }
    
        patch "/api/v1/medical_professionals/1", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
      end

      context 'missing params' do
        it "returns 422 if profession is missing from request params" do
      
          patch "/api/v1/medical_professionals/1",  
          headers: { 
            "Content-Type": "application/json", 
            "Accept": "application/json",
            "api-key": "aidanisthebest"
          }
          
          expect(response).to_not be_successful
          expect(response.status).to eq(400)
        end
      end
    end
  end
end