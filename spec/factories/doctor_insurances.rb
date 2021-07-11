FactoryBot.define do
  factory :doctor_insurance do
    association :doctor, factory: :doctor
    association :insurance, factory: :insurance
  end
end
