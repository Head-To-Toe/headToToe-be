Insurance.destroy_all
Specialty.destroy_all
Doctor.destroy_all
MentalHealthProfessional.destroy_all

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
    vetted: [true, false].sample,
    phone: '234-456-2244'
)
end

150.times do MentalHealthProfessional.create!(
    first_name: Faker::Creature::Animal.name,
    last_name: Faker::Games::Pokemon.name,
    state: Faker::Address.state,
    city: Faker::Address.city,
    street: Faker::Address.street_address,
    zip: '10385',
    unit: Faker::Address.secondary_address,
    vetted: [true, false].sample,
    phone: '234-456-2244',
    cost: '$123-150'
)
end

300.times { DoctorInsurance.find_or_create_by!(doctor_id: Doctor.all.sample.id, insurance_id: Insurance.all.sample.id) }
300.times { DoctorSpecialty.find_or_create_by!(doctor_id: Doctor.all.sample.id, specialty_id: Specialty.all.sample.id) }

300.times { MhpInsurance.find_or_create_by!(mental_health_professional_id: MentalHealthProfessional.all.sample.id, insurance_id: Insurance.all.sample.id) }
300.times { MhpSpecialty.find_or_create_by!(mental_health_professional_id: MentalHealthProfessional.all.sample.id, specialty_id: Specialty.all.sample.id) }
