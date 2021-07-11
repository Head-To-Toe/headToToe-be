FactoryBot.define do
  factory :mental_health_professional do
    first_name {Faker::Creature::Animal.name}
    last_name {Faker::Games::Pokemon.name}
    state {Faker::Address.state}
    city {Faker::Address.city}
    street {Faker::Address.street_address}
    zip {'10385'}
    unit {Faker::Address.secondary_address}
    vetted {[true, false].sample}
    phone {'234-456-2244'}
    cost {'$123-150'}
  end
end
