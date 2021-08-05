Insurance.destroy_all
Specialty.destroy_all
Doctor.destroy_all
MentalHealthProfessional.destroy_all

15.times { Insurance.find_or_create_by!( company: Faker::Types.rb_string ) }
15.times { Specialty.find_or_create_by!( name: Faker::Types.rb_string ) }

150.times do Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    state: Faker::Address.state,
    city: Faker::Address.city,
    zip: '19384',
    street: Faker::Address.street_address,
    unit: Faker::Address.secondary_address,
    vetted: [true, false].sample,
    phone: '234-456-2244'
)
end

10.times do Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    state: 'Colorado',
    city: Faker::Address.city,
    zip: '19384',
    street: Faker::Address.street_address,
    unit: Faker::Address.secondary_address,
    vetted: true,
    phone: '234-456-2244'
)
end

10.times do MentalHealthProfessional.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    state: 'Colorado',
    city: Faker::Address.city,
    street: Faker::Address.street_address,
    zip: '10385',
    unit: Faker::Address.secondary_address,
    vetted: true,
    phone: '234-456-2244',
    cost: '$123-150'
)
end

150.times do MentalHealthProfessional.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
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
