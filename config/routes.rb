Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :medical_professionals, only: [:index, :create, :update, :destroy]
    end
  end
end
