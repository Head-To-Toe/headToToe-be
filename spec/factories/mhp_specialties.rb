FactoryBot.define do
  factory :mhp_specialty do
    association :mental_health_professional, factory: :mental_health_professional
    association :specialty, factory: :specialty
  end
end
