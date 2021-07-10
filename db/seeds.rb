Insurance.destroy_all
Specialty.destroy_all
Doctor.destroy_all
MentalHealthProfessional.destroy_all

random_boolean = [true, false].sample

15.times { Insurance.create!( company: Faker::Company.name ) }
15.times { Specialty.create!( name: Faker::Games::DnD.language ) }

150.times do Doctor.create!(
    first_name: Faker::Creature::Animal.name,
    last_name: Faker::Games::Pokemon.name,
    state: Faker::Address.state,
    city: Faker::Address.city,
    zip: '19384',
    street: Faker::Address.street_address,
    unit: Faker::Address.secondary_address,
    vetted: random_boolean,
    phone: '234-456-2244',
    specialty_id: Specialty.all.sample.id,
    insurance_id: Insurance.all.sample.id)
end

150.times do MentalHealthProfessional.create!(
    first_name: Faker::Creature::Animal.name,
    last_name: Faker::Games::Pokemon.name,
    state: Faker::Address.state,
    city: Faker::Address.city,
    street: Faker::Address.street_address,
    zip: '10385',
    unit: Faker::Address.secondary_address,
    vetted: random_boolean,
    phone: '234-456-2244',
    cost: '$123-150',
    specialty_id: Specialty.all.sample.id,
    insurance_id: Insurance.all.sample.id)
end
