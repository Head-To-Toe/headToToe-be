require 'rails_helper'

describe "medical professional requests" do
  context 'happy path' do
    it "returns all doctor json objects" do
      doctors            = create_list(:doctor, 20, vetted: true)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {type: 'doctor', state: 'Colorado'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      doctors = JSON.parse(response.body, symbolize_names: true)
      
      expect(doctors).to have_key(:data)
      expect(doctors[:data].count).to eq(3)
      expect(doctors[:data]).to be_a(Hash)

      expect(doctors[:data]).to have_key(:id)
      expect(doctors[:data][:id]).to eq(nil)

      expect(doctors[:data]).to have_key(:type)
      expect(doctors[:data][:type]).to eq('vetted_professionals')

      expect(doctors[:data]).to have_key(:attributes)
      expect(doctors[:data][:attributes]).to be_a(Hash)
      expect(doctors[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(doctors[:data][:attributes][:doctors]).to be_an(Array)
      
      expect(doctors[:data][:attributes][:doctors].count.zero?).to eq(false)

      doctors[:data][:attributes][:doctors].each do |doctor|
        expect(doctor).to have_key(:id)
        expect(doctor[:id]).to be_an(Integer)

        expect(doctor).to have_key(:first_name)
        expect(doctor[:first_name]).to be_a(String)

        expect(doctor).to have_key(:state)
        expect(doctor[:state]).to be_a(String)

        expect(doctor).to have_key(:city)
        expect(doctor[:city]).to be_a(String)

        expect(doctor).to have_key(:street)
        expect(doctor[:street]).to be_a(String)

        expect(doctor).to have_key(:unit)
        expect(doctor[:unit]).to be_a(String)

        expect(doctor).to have_key(:zip)
        expect(doctor[:zip]).to be_a(String)

        expect(doctor).to have_key(:phone)
        expect(doctor[:phone]).to be_a(String)

        expect(doctor).to have_key(:vetted)
        expect(doctor[:vetted]).to eq(true)

        expect(doctor).to have_key(:specialties)
        expect(doctor[:specialties]).to be_an(Array)

        expect(doctor).to have_key(:insurances)
        expect(doctor[:insurances]).to be_an(Array)
      end
    end

    it "returns all mental health professional json objects" do
      mhps            = create_list(:mental_health_professional, 20, vetted: true)

      insurances      = create_list(:insurance, 10)
      specialties     = create_list(:specialty, 10)

      mhp_insurances  = create_list(:mhp_insurance, 10, mental_health_professional: mhps.sample, insurance: insurances.sample)
      mhp_specialties = create_list(:mhp_specialty, 10, mental_health_professional: mhps.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {type: 'mhp', state: 'Colorado'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      mental_health_professional = JSON.parse(response.body, symbolize_names: true)
      
      expect(mental_health_professional).to have_key(:data)
      expect(mental_health_professional[:data].count).to eq(3)
      expect(mental_health_professional[:data]).to be_a(Hash)

      expect(mental_health_professional[:data]).to have_key(:id)
      expect(mental_health_professional[:data][:id]).to eq(nil)

      expect(mental_health_professional[:data]).to have_key(:type)
      expect(mental_health_professional[:data][:type]).to eq('vetted_professionals')

      expect(mental_health_professional[:data]).to have_key(:attributes)
      expect(mental_health_professional[:data][:attributes]).to be_a(Hash)
      
      expect(mental_health_professional[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(mental_health_professional[:data][:attributes][:mhps]).to be_an(Array)

      expect(mental_health_professional[:data][:attributes][:mhps].count.zero?).to eq(false)

      mental_health_professional[:data][:attributes][:mhps].each do |mhp|
        expect(mhp).to have_key(:id)
        expect(mhp[:id]).to be_an(Integer)

        expect(mhp).to have_key(:first_name)
        expect(mhp[:first_name]).to be_a(String)

        expect(mhp).to have_key(:state)
        expect(mhp[:state]).to be_a(String)

        expect(mhp).to have_key(:city)
        expect(mhp[:city]).to be_a(String)

        expect(mhp).to have_key(:street)
        expect(mhp[:street]).to be_a(String)

        expect(mhp).to have_key(:unit)
        expect(mhp[:unit]).to be_a(String)

        expect(mhp).to have_key(:zip)
        expect(mhp[:zip]).to be_a(String)

        expect(mhp).to have_key(:phone)
        expect(mhp[:phone]).to be_a(String)

        expect(mhp).to have_key(:vetted)
        expect(mhp[:vetted]).to eq(true)

        expect(mhp).to have_key(:cost)
        expect(mhp[:cost]).to be_a(String)

        expect(mhp).to have_key(:specialties)
        expect(mhp[:specialties]).to be_an(Array)

        expect(mhp).to have_key(:insurances)
        expect(mhp[:insurances]).to be_an(Array)
      end
    end

    it 'does not require the state param, returns all vetted resources' do 
      doctors            = create_list(:doctor, 20, vetted: true)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {type: 'doctor'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      doctors = JSON.parse(response.body, symbolize_names: true)
      
      expect(doctors).to have_key(:data)
      expect(doctors[:data].count).to eq(3)
      expect(doctors[:data]).to be_a(Hash)

      expect(doctors[:data]).to have_key(:id)
      expect(doctors[:data][:id]).to eq(nil)

      expect(doctors[:data]).to have_key(:type)
      expect(doctors[:data][:type]).to eq('vetted_professionals')

      expect(doctors[:data]).to have_key(:attributes)
      expect(doctors[:data][:attributes]).to be_a(Hash)
      expect(doctors[:data][:attributes]).to have_key(:doctors)

      expect(doctors[:data][:attributes][:doctors]).to be_an(Array)

      expect(doctors[:data][:attributes][:doctors].count).to eq(20)
      
      doctors[:data][:attributes][:doctors].each do |doctor|
        expect(doctor).to have_key(:id)
        expect(doctor[:id]).to be_an(Integer)

        expect(doctor).to have_key(:first_name)
        expect(doctor[:first_name]).to be_a(String)

        expect(doctor).to have_key(:state)
        expect(doctor[:state]).to be_a(String)

        expect(doctor).to have_key(:city)
        expect(doctor[:city]).to be_a(String)

        expect(doctor).to have_key(:street)
        expect(doctor[:street]).to be_a(String)

        expect(doctor).to have_key(:unit)
        expect(doctor[:unit]).to be_a(String)

        expect(doctor).to have_key(:zip)
        expect(doctor[:zip]).to be_a(String)

        expect(doctor).to have_key(:phone)
        expect(doctor[:phone]).to be_a(String)

        expect(doctor).to have_key(:vetted)
        expect(doctor[:vetted]).to eq(true)

        expect(doctor).to have_key(:specialties)
        expect(doctor[:specialties]).to be_an(Array)

        expect(doctor).to have_key(:insurances)
        expect(doctor[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted professionals if vetted=false & no other params' do 
      doctors            = create_list(:doctor, 10, vetted: false)
      mhps               = create_list(:mental_health_professional, 10, vetted: false)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      mhp_insurances  = create_list(:mhp_insurance, 10, mental_health_professional: mhps.sample, insurance: insurances.sample)
      mhp_specialties = create_list(:mhp_specialty, 10, mental_health_professional: mhps.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(unvetted_pros[:data][:attributes][:doctors]).to be_an(Array)
      expect(unvetted_pros[:data][:attributes][:mhps]).to be_an(Array)
      
      expect(unvetted_pros[:data][:attributes][:doctors].count).to eq(10)
      expect(unvetted_pros[:data][:attributes][:mhps].count).to eq(10)

      unvetted_pros[:data][:attributes][:doctors].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to be_a(String)

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end

      unvetted_pros[:data][:attributes][:mhps].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to be_a(String)

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:cost)
        expect(unvetted[:cost]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted doctors if vetted=false & type=doctor' do 
      create(:mental_health_professional, vetted: false)

      doctors            = create_list(:doctor, 20, vetted: false)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false, type: 'doctor'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(unvetted_pros[:data][:attributes][:doctors]).to be_an(Array)
      expect(unvetted_pros[:data][:attributes][:mhps]).to eq(nil)
      
      expect(unvetted_pros[:data][:attributes][:doctors].count).to eq(20)

      unvetted_pros[:data][:attributes][:doctors].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to be_a(String)

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted doctors in CO if vetted=false & type=doctor & state=Colorado' do
      create(:mental_health_professional, vetted: false)

      doctors            = create_list(:doctor, 20, vetted: false)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false, type: 'doctor', state: 'Colorado'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(unvetted_pros[:data][:attributes][:doctors]).to be_an(Array)
      expect(unvetted_pros[:data][:attributes][:mhps]).to eq(nil)
      
      expect(unvetted_pros[:data][:attributes][:doctors].count.zero?).to eq(false)

      unvetted_pros[:data][:attributes][:doctors].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to eq('Colorado')

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted mhps if vetted=false & type=mhp' do 
      create(:doctor, vetted: false)

      mhps            = create_list(:mental_health_professional, 20, vetted: false)

      insurances      = create_list(:insurance, 10)
      specialties     = create_list(:specialty, 10)

      mhp_insurances  = create_list(:mhp_insurance, 10, mental_health_professional: mhps.sample, insurance: insurances.sample)
      mhp_specialties = create_list(:mhp_specialty, 10, mental_health_professional: mhps.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false, type: 'mhp'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(unvetted_pros[:data][:attributes][:doctors]).to eq(nil)
      expect(unvetted_pros[:data][:attributes][:mhps]).to be_an(Array)
      
      expect(unvetted_pros[:data][:attributes][:mhps].count).to eq(20)

      unvetted_pros[:data][:attributes][:mhps].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to be_a(String)

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:cost)
        expect(unvetted[:cost]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted mhps in CO if vetted=false & type=mhp & state=Colorado' do 
      create(:doctor, vetted: false)

      mhps            = create_list(:mental_health_professional, 20, vetted: false)

      insurances      = create_list(:insurance, 10)
      specialties     = create_list(:specialty, 10)

      mhp_insurances  = create_list(:mhp_insurance, 10, mental_health_professional: mhps.sample, insurance: insurances.sample)
      mhp_specialties = create_list(:mhp_specialty, 10, mental_health_professional: mhps.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false, type: 'mhp', state: 'Colorado'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])
      
      expect(unvetted_pros[:data][:attributes][:doctors]).to eq(nil)
      expect(unvetted_pros[:data][:attributes][:mhps]).to be_an(Array)
      
      expect(unvetted_pros[:data][:attributes][:mhps].count.zero?).to eq(false)

      unvetted_pros[:data][:attributes][:mhps].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to eq('Colorado')

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:cost)
        expect(unvetted[:cost]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end

    it 'returns all unvetted professionals in CO if vetted=false & state=Colorado' do 
      create(:doctor, vetted: false, state: 'Colorado')
      create(:mental_health_professional, vetted: false, state: 'Colorado')

      doctors            = create_list(:doctor, 10, vetted: false)
      mhps               = create_list(:mental_health_professional, 10, vetted: false)

      insurances         = create_list(:insurance, 10)
      specialties        = create_list(:specialty, 10)

      doctor_insurances  = create_list(:doctor_insurance, 10, doctor: doctors.sample, insurance: insurances.sample)
      doctor_specialties = create_list(:doctor_specialty, 10, doctor: doctors.sample, specialty: specialties.sample)

      mhp_insurances  = create_list(:mhp_insurance, 10, mental_health_professional: mhps.sample, insurance: insurances.sample)
      mhp_specialties = create_list(:mhp_specialty, 10, mental_health_professional: mhps.sample, specialty: specialties.sample)

      get '/api/v1/medical_professionals', params: {vetted: false, state: 'Colorado'}
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      unvetted_pros = JSON.parse(response.body, symbolize_names: true)
      
      expect(unvetted_pros).to have_key(:data)
      expect(unvetted_pros[:data].count).to eq(3)
      expect(unvetted_pros[:data]).to be_a(Hash)

      expect(unvetted_pros[:data]).to have_key(:id)
      expect(unvetted_pros[:data][:id]).to eq(nil)
      
      expect(unvetted_pros[:data]).to have_key(:type)
      expect(unvetted_pros[:data][:type]).to eq('unvetted_professionals')

      expect(unvetted_pros[:data]).to have_key(:attributes)
      expect(unvetted_pros[:data][:attributes]).to be_a(Hash)
      expect(unvetted_pros[:data][:attributes].keys).to eq([:doctors, :mhps])

      expect(unvetted_pros[:data][:attributes][:doctors]).to be_an(Array)
      expect(unvetted_pros[:data][:attributes][:mhps]).to be_an(Array)
      
      expect(unvetted_pros[:data][:attributes][:doctors].count.zero?).to eq(false)
      expect(unvetted_pros[:data][:attributes][:mhps].count.zero?).to eq(false)

      unvetted_pros[:data][:attributes][:doctors].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to eq('Colorado')

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end

      unvetted_pros[:data][:attributes][:mhps].each do |unvetted|
        expect(unvetted).to have_key(:id)
        expect(unvetted[:id]).to be_an(Integer)

        expect(unvetted).to have_key(:first_name)
        expect(unvetted[:first_name]).to be_a(String)

        expect(unvetted).to have_key(:state)
        expect(unvetted[:state]).to eq('Colorado')

        expect(unvetted).to have_key(:city)
        expect(unvetted[:city]).to be_a(String)

        expect(unvetted).to have_key(:street)
        expect(unvetted[:street]).to be_a(String)

        expect(unvetted).to have_key(:unit)
        expect(unvetted[:unit]).to be_a(String)

        expect(unvetted).to have_key(:zip)
        expect(unvetted[:zip]).to be_a(String)

        expect(unvetted).to have_key(:phone)
        expect(unvetted[:phone]).to be_a(String)

        expect(unvetted).to have_key(:cost)
        expect(unvetted[:cost]).to be_a(String)

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end
  end
end