FactoryBot.define do
  factory :mhp_insurance do
    association :mental_health_professional, factory: :mental_health_professional
    association :insurance, factory: :insurance
  end
end