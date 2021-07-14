require 'rails_helper'

RSpec.describe 'DELETE /medical_professionals' do
  context 'happy path' do
    context 'doctor delete' do
      it "deletes desired unvetted record from the database" do
        doctor = create :doctor, vetted: false

        expect(doctor.present?).to eq(true)

        body = {
            id: doctor.id,
            first_name: doctor.first_name,
            last_name: doctor.last_name
        }
    
        delete "/api/v1/medical_professionals/#{doctor.id}", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to be_successful
        expect(response.status).to eq(204)

        expect(Doctor.all.empty?).to eq(true)
      end
    end

    context 'mental health professional delete' do
      it "deletes desired unvetted record from the database" do
        mhp    = create :mental_health_professional, vetted: false

        expect(mhp.present?).to eq(true)

        body = {
            id: mhp.id,
            first_name: mhp.first_name,
            last_name: mhp.last_name
        }
    
        delete "/api/v1/medical_professionals/#{mhp.id}", 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api-key": "aidanisthebest"
        }
        
        expect(response).to be_successful
        expect(response.status).to eq(204)

        expect(MentalHealthProfessional.all.empty?).to eq(true)
      end
    end
  end

  context 'sad path' do
    context 'failed status codes' do
      it "returns 401 if api_key is not passed as header" do
        doctor = create :doctor, vetted: false

        body = {
            id: doctor.id,
            first_name: doctor.first_name,
            last_name: doctor.last_name,
        }
    
        delete "/api/v1/medical_professionals/#{doctor.id}", 
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
    
        delete "/api/v1/medical_professionals/#{doctor.id}", 
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
      
          delete "/api/v1/medical_professionals/#{doctor.id}", 
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
      
          delete "/api/v1/medical_professionals/#{doctor.id}", 
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
      
          delete "/api/v1/medical_professionals/#{doctor.id}", 
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