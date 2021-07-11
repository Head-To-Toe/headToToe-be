FactoryBot.define do
  factory :doctor_specialty do
    association :doctor, factory: :doctor
    association :specialty, factory: :specialty
  end
end
