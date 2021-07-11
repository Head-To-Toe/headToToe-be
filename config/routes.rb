Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/medical_professionals", to: 'medical_professionals#index'

      post "/add_professional", to: 'add_professional#create'
    end
  end
end
