require 'rails_helper'

RSpec.describe 'POST /add_professional' do
  context 'happy path' do
    context 'doctors' do
      it 'creates a new doctor record' do
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
            insurance: ["BigMoney", "OtherBigMoney"],
            specialties: ["Stuff", "Things", "Problems"]
        }
    
        post '/api/v1/add_professional', 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api_key": "aidanisthebest"
        }
    
        expect(response).to be_successful
        expect(response.status).to eq(201)
  
        doctor = Doctor.find_by(first_name: "FirstName")
  
        expect(doctor.last_name).to eq('LastName')
        expect(doctor.street).to eq('123 Street')
        expect(doctor.unit).to eq('123 Unit')
        expect(doctor.city).to eq('Denver')
        expect(doctor.state).to eq('Colorado')
        expect(doctor.zip).to eq('12345')
        expect(doctor.phone).to eq('1234567890')
        expect(doctor.insurances.first.company).to eq("BigMoney")
        expect(doctor.insurances.last.company).to eq("OtherBigMoney")
        expect(doctor.specialties[0].name).to eq("Stuff")
        expect(doctor.specialties[1].name).to eq("Things")
        expect(doctor.specialties[2].name).to eq("Problems")
      end
    end
    context 'mental health professionals' do
      it 'creates a new mhp record' do
        body = {
            first_name: "FirstName",
            last_name: "LastName",
            street: "123 Street",
            unit: "123 Unit",
            city: "Denver",
            state: "Colorado",
            zip: "12345",
            phone: "1234567890",
            cost: "$100-120",
            profession: "mhp",
            insurance: ["BigMoney", "OtherBigMoney"],
            specialties: ["Stuff", "Things", "Problems"]
        }
    
        post '/api/v1/add_professional', 
        params: body.to_json, 
        headers: { 
          "Content-Type": "application/json", 
          "Accept": "application/json",
          "api_key": "aidanisthebest"
        }
    
        expect(response).to be_successful
        expect(response.status).to eq(201)
  
        mhp = MentalHealthProfessional.find_by(first_name: "FirstName")
  
        expect(mhp.last_name).to eq('LastName')
        expect(mhp.street).to eq('123 Street')
        expect(mhp.unit).to eq('123 Unit')
        expect(mhp.city).to eq('Denver')
        expect(mhp.state).to eq('Colorado')
        expect(mhp.zip).to eq('12345')
        expect(mhp.phone).to eq('1234567890')
        expect(mhp.cost).to eq('$100-120')
        expect(mhp.insurances.first.company).to eq("BigMoney")
        expect(mhp.insurances.last.company).to eq("OtherBigMoney")
        expect(mhp.specialties[0].name).to eq("Stuff")
        expect(mhp.specialties[1].name).to eq("Things")
        expect(mhp.specialties[2].name).to eq("Problems")
      end
    end
  end
end