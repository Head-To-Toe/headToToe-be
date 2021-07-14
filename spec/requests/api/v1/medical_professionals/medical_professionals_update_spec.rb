require 'rails_helper'

RSpec.describe 'PATCH /medical_professionals' do
  context 'happy path' do
    context 'doctor update' do
      it "updates record's vetted attribute from false to true" do
        doctor = create :doctor, vetted: false

        expect(doctor.vetted).to eq(false)

        body = {
            id: doctor.id,
            first_name: doctor.first_name,
            last_name: doctor.last_name
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
            id: mhp.id,
            first_name: mhp.first_name,
            last_name: mhp.last_name
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
            id: doctor.id,
            first_name: doctor.first_name,
            last_name: doctor.last_name,
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

      it "returns 404 if no doctor or mhp are found from passed first_name and last_name" do
        doctor = create :doctor, vetted: false

        body = {
            id: 'random id',
            first_name: 'firstname',
            last_name: 'lastname'
        }
    
        patch "/api/v1/medical_professionals/#{doctor.id}", 
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
        it "returns 422 if id is missing from request params" do
          doctor = create :doctor, vetted: false

          body = {
              first_name: 'firstname',
              last_name: 'lastname'
          }
      
          patch "/api/v1/medical_professionals/#{doctor.id}", 
          params: body.to_json, 
          headers: { 
            "Content-Type": "application/json", 
            "Accept": "application/json",
            "api-key": "aidanisthebest"
          }
          
          expect(response).to_not be_successful
          expect(response.status).to eq(422)
        end

        it "returns 422 if first_name is missing from request params" do
          doctor = create :doctor, vetted: false

          body = {
              id: 'random id',
              last_name: 'lastname'
          }
      
          patch "/api/v1/medical_professionals/#{doctor.id}", 
          params: body.to_json, 
          headers: { 
            "Content-Type": "application/json", 
            "Accept": "application/json",
            "api-key": "aidanisthebest"
          }
          
          expect(response).to_not be_successful
          expect(response.status).to eq(422)
        end

        it "returns 422 if last_name is missing from request params" do
          doctor = create :doctor, vetted: false

          body = {
              id: 'random id',
              first_name: 'firstname'
          }
      
          patch "/api/v1/medical_professionals/#{doctor.id}", 
          params: body.to_json, 
          headers: { 
            "Content-Type": "application/json", 
            "Accept": "application/json",
            "api-key": "aidanisthebest"
          }
          
          expect(response).to_not be_successful
          expect(response.status).to eq(422)
        end
      end
    end
  end
end