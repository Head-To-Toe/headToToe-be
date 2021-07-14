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
      expect(doctors[:data][:type]).to eq('doctor')

      expect(doctors[:data]).to have_key(:attributes)
      expect(doctors[:data][:attributes]).to be_a(Hash)
      expect(doctors[:data][:attributes]).to have_key(:list)

      expect(doctors[:data][:attributes][:list]).to be_an(Array)
      
      expect(doctors[:data][:attributes][:list].count.zero?).to eq(false)

      doctors[:data][:attributes][:list].each do |doctor|
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
      expect(mental_health_professional[:data][:type]).to eq('mhp')

      expect(mental_health_professional[:data]).to have_key(:attributes)
      expect(mental_health_professional[:data][:attributes]).to be_a(Hash)
      expect(mental_health_professional[:data][:attributes]).to have_key(:list)

      expect(mental_health_professional[:data][:attributes][:list]).to be_an(Array)

      expect(mental_health_professional[:data][:attributes][:list].count.zero?).to eq(false)

      mental_health_professional[:data][:attributes][:list].each do |mhp|
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
      doctors               = create_list(:doctor, 20, vetted: true)

      insurances            = create_list(:insurance, 10)
      specialties           = create_list(:specialty, 10)

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
      expect(doctors[:data][:type]).to eq('doctor')

      expect(doctors[:data]).to have_key(:attributes)
      expect(doctors[:data][:attributes]).to be_a(Hash)
      expect(doctors[:data][:attributes]).to have_key(:list)

      expect(doctors[:data][:attributes][:list]).to be_an(Array)

      expect(doctors[:data][:attributes][:list].count).to eq(20)
      
      doctors[:data][:attributes][:list].each do |doctor|
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

        expect(unvetted).to have_key(:vetted)
        expect(unvetted[:vetted]).to eq(false)

        expect(unvetted).to have_key(:specialties)
        expect(unvetted[:specialties]).to be_an(Array)

        expect(unvetted).to have_key(:insurances)
        expect(unvetted[:insurances]).to be_an(Array)
      end
    end
  end

  # it "returns a subset of items based on desired page number" do
  #   merchant              = create(:merchant)
  #   merchant_2            = create(:merchant)
  #   merchant_1_items      = create_list(:item, 20, merchant: merchant)
  #   merchant_2_items      = create_list(:item, 20, merchant: merchant_2)

  #   get '/api/v1/items', params: {page: 2}

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)
  #   expect(response.error?).to eq(false)

  #   items = JSON.parse(response.body, symbolize_names: true)

  #   expect(items[:data][0][:id].to_i).to eq(merchant_2_items[0].id)
  # end

  # it "returns a subset of item based on per_page limitation" do
  #   merchant              = create(:merchant)
  #   merchant_2            = create(:merchant)
  #   merchant_1_items      = create_list(:item, 20, merchant: merchant)
  #   merchant_2_items      = create_list(:item, 20, merchant: merchant_2)

  #   get '/api/v1/items', params: {per_page: 5}

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)
  #   expect(response.error?).to eq(false)

  #   items = JSON.parse(response.body, symbolize_names: true)

  #   expect(items[:data].count).to eq(5)
  # end

  # it "returns one item by its id" do
  #   id = create(:item).id

  #   get "/api/v1/items/#{id}"

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)
  #   expect(response.error?).to eq(false)

  #   item = JSON.parse(response.body, symbolize_names: true)

  #   expect(item).to have_key(:data)
  #   expect(item[:data]).to be_a(Hash)

  #   expect(item[:data]).to have_key(:id)
  #   expect(item[:data][:id]).to be_a(String)
  #   expect(item[:data][:id].to_i).to eq(id)

  #   expect(item[:data]).to have_key(:type)
  #   expect(item[:data][:type]).to be_an(Object)

  #   expect(item[:data]).to have_key(:attributes)
  #   expect(item[:data][:attributes]).to be_a(Hash)


  #   expect(item[:data][:attributes]).to have_key(:name)
  #   expect(item[:data][:attributes][:name]).to be_a(String)

  #   expect(item[:data][:attributes]).to have_key(:description)
  #   expect(item[:data][:attributes][:description]).to be_a(String)

  #   expect(item[:data][:attributes]).to have_key(:unit_price)
  #   expect(item[:data][:attributes][:unit_price]).to be_a(Float)

  #   expect(item[:data][:attributes]).to have_key(:merchant_id)
  #   expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  # end

  # it "creates then deletes an item" do
  #   merchant    = create(:merchant)
  #   item_params = ({
  #                   name:         'Yeah boi',
  #                   description:  'Im the fastest',
  #                   unit_price:   123.56,
  #                   merchant_id:  merchant.id
  #                 })
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #   post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

  #   created_item = Item.last

  #   expect(response).to be_successful
  #   expect(response.error?).to eq(false)

  #   expect(Item.count).to eq(1)
  #   expect(created_item.name).to eq(item_params[:name])
  #   expect(created_item.description).to eq(item_params[:description])
  #   expect(created_item.unit_price).to eq(item_params[:unit_price])
  #   expect(created_item.merchant_id).to eq(item_params[:merchant_id])

  #   delete "/api/v1/items/#{created_item.id}"

  #   expect(response).to be_successful
  #   expect(Item.count).to eq(0)
  #   expect{Item.find(created_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  # end

  # it "can update an existing item" do
  #   id = create(:item).id
  #   previous_name = Item.last.name
  #   item_params = { name: "Spider Man" }
  #   headers = {"CONTENT_TYPE" => "application/json"}

  #   put "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
  #   item = Item.find_by(id: id)

  #   expect(response).to be_successful
  #   expect(item.name).to_not eq(previous_name)
  #   expect(item.name).to eq("Spider Man")
  # end

  # it "attempts to update item with invalid merchant id" do
  #   id = create(:item).id
  #   previous_name = Item.last.name
  #   item_params = { name: "Spider Man", merchant_id: 25 }
  #   headers = {"CONTENT_TYPE" => "application/json"}

  #   put "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
  #   item = Item.find_by(id: id)

  #   expect(response.status).to eq(404)
  #   expect(item.name).to eq(previous_name)
  # end

  # it "returns a single item's merchant by their id" do
  #   merchant_1      = create(:merchant)
  #   merchant_2      = create(:merchant)
  #   merchant_3      = create(:merchant)
  #   merchant_1_item = create(:item, merchant: merchant_1)
  #   merchant_2_item = create(:item, merchant: merchant_2)
  #   merchant_3_item = create(:item, merchant: merchant_3)

  #   get "/api/v1/items/#{merchant_2_item.id}/merchant"

  #   expect(response).to be_successful
  #   expect(response.status).to eq(200)
  #   expect(response.error?).to eq(false)

  #   merchant_response = JSON.parse(response.body, symbolize_names: true)

  #   expect(merchant_response).to have_key(:data)
  #   expect(merchant_response[:data]).to be_a(Hash)

  #   expect(merchant_response[:data]).to have_key(:id)
  #   expect(merchant_response[:data][:id]).to be_a(String)

  #   expect(merchant_response[:data]).to have_key(:attributes)
  #   expect(merchant_response[:data][:attributes]).to be_an(Hash)

  #   expect(merchant_response[:data][:attributes]).to have_key(:name)
  #   expect(merchant_response[:data][:attributes][:name]).to be_a(String)
  # end

  # describe 'items with most revenue endpoint' do
  #   it "successfully returns top n items based on their revenue generated" do
  #     top_3 = 3

  #     merchant_1 = create :merchant
  #     merchant_2 = create :merchant
  #     merchant_3 = create :merchant
  #     merchant_4 = create :merchant

  #     customer = create :customer

  #     item_1 = create :item, merchant: merchant_1
  #     item_2 = create :item, merchant: merchant_2
  #     item_3 = create :item, merchant: merchant_3
  #     item_4 = create :item, merchant: merchant_4

  #     # 20 dollars in revenue generated for item_1
  #     invoice_2 = customer.invoices.create!(status: 'shipped', merchant: merchant_1)
  #     invoice_2.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_2.invoice_items.create!(item: item_1, quantity: 1, unit_price: 10)
  #     invoice_2.invoice_items.create!(item: item_1, quantity: 10, unit_price: 1)

  #     # 250 dollars generated for item_2
  #     invoice_3a = customer.invoices.create!(status: 'shipped', merchant: merchant_2)
  #     invoice_3b = customer.invoices.create!(status: 'shipped', merchant: merchant_2)
  #     invoice_3a.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_3b.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_3a.invoice_items.create!(item: item_2, quantity: 125, unit_price: 1)
  #     invoice_3b.invoice_items.create!(item: item_2, quantity: 125, unit_price: 1)

  #     # 650 dollars generated for item_3
  #     invoice_4a = customer.invoices.create!(status: 'shipped', merchant: merchant_3)
  #     invoice_4b = customer.invoices.create!(status: 'shipped', merchant: merchant_3)
  #     invoice_4a.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_4b.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_4a.invoice_items.create!(item: item_3, quantity: 500, unit_price: 1)
  #     invoice_4b.invoice_items.create!(item: item_3, quantity: 150, unit_price: 1)

  #     # 500 dollars generated for item_4
  #     invoice_5a = customer.invoices.create!(status: 'shipped', merchant: merchant_4)
  #     invoice_5b = customer.invoices.create!(status: 'shipped', merchant: merchant_4)
  #     invoice_5a.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_5b.transactions.create!(result: 'success', credit_card_number: '12345', credit_card_expiration_date: '12/7')
  #     invoice_5a.invoice_items.create!(item: item_4, quantity: 300, unit_price: 1)
  #     invoice_5b.invoice_items.create!(item: item_4, quantity: 200, unit_price: 1)

  #     quantity_params = ({
  #                     quantity: 3,
  #                   })
  #     headers = {"CONTENT_TYPE" => "application/json"}
  #     get "/api/v1/revenue/items", headers: headers, params: quantity_params

  #     expect(response).to be_successful
  #     expect(response.status).to eq(200)
  #     expect(response.server_error?).to eq(false)

  #     top_3_items = JSON.parse(response.body, symbolize_names: true)

  #     expect(top_3_items).to have_key(:data)
  #     expect(top_3_items[:data].count).to eq(3)
  #     expect(top_3_items[:data]).to be_an(Array)

  #     top_3_items[:data].each do |item|
  #       expect(item).to have_key(:id)
  #       expect(item[:id]).to be_an(String)
  #       expect(item[:attributes]).to be_a(Hash)

  #       expect(item).to have_key(:type)
  #       expect(item[:type]).to eq("item_revenue")

  #       expect(item[:attributes]).to have_key(:name)
  #       expect(item[:attributes][:name]).to be_a(String)

  #       expect(item[:attributes]).to have_key(:description)
  #       expect(item[:attributes][:description]).to be_a(String)

  #       expect(item[:attributes]).to have_key(:merchant_id)
  #       expect(item[:attributes][:merchant_id]).to be_an(Integer)

  #       expect(item[:attributes]).to have_key(:unit_price)
  #       expect(item[:attributes][:unit_price]).to be_a(Float)

  #       expect(item[:attributes]).to have_key(:revenue)
  #       expect(item[:attributes][:revenue]).to be_a(Float)
  #     end

  #     # returns the top 3 items in order of their total revenue generated.
  #     # Doesn't include item_1 as they didn't make the top 3 cut.
  #     expect(top_3_items[:data].first[:attributes][:name]).to eq(item_3.name)
  #     expect(top_3_items[:data].second[:attributes][:name]).to eq(item_4.name)
  #     expect(top_3_items[:data].third[:attributes][:name]).to eq(item_2.name)
  #   end

  #   it "returns 404 status when missing params or passing negative params" do
  #     get "/api/v1/revenue/items"

  #     expect(response.successful?).to eq(false)
  #     expect(response.status).to eq(400)
  #     expect(response.server_error?).to eq(false)
  #   end
  # end
end
