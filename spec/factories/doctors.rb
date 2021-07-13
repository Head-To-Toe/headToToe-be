FactoryBot.define do
  factory :doctor do
    first_name {Faker::Creature::Animal.name}
    last_name {Faker::Games::Pokemon.name}
    state {['Colorado', 'New York', 'Ohio', 'California'].sample}
    city {Faker::Address.city}
    zip {'19384'}
    street {Faker::Address.street_address}
    unit {Faker::Address.secondary_address}
    vetted {[true, false].sample}
    phone {'234-456-2244'}
  end
end