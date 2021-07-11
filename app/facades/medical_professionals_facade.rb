class MedicalProfessionalsFacade
  class << self
    def depict_profession(type, state)
      care_givers = format_doctors(get_all_vetted_doctors(type, state)) if type == 'doctor'
      care_givers = format_mhp(get_all_vetted_mhp(type, state)) if type == 'mhp'
      OpenStruct.new(id: nil, list: care_givers)
    end

    def get_all_vetted_doctors(_type, state)
      Doctor.where(vetted: true, state: state)
    end

    def get_all_vetted_mhp(_type, state)
      MentalHealthProfessional.where(vetted: true, state: state)
    end

    def format_doctors(doctors)
      doctors.map do |doctor|
        {
          id: doctor.id,
          first_name: doctor.first_name,
          last_name: doctor.last_name,
          state: doctor.state,
          city: doctor.city,
          street: doctor.street,
          unit: doctor.unit,
          zip: doctor.zip,
          phone: doctor.phone,
          vetted: doctor.vetted,
          specialties: doctor.specialties,
          insurances: doctor.insurances
        }
      end
    end

    def format_mhp(mental_health_professionals)
      mental_health_professionals.map do |mhp|
        {
          id: mhp.id,
          first_name: mhp.first_name,
          last_name: mhp.last_name,
          state: mhp.state,
          city: mhp.city,
          street: mhp.street,
          unit: mhp.unit,
          zip: mhp.zip,
          phone: mhp.phone,
          vetted: mhp.vetted,
          cost: mhp.cost,
          specialties: mhp.specialties,
          insurances: mhp.insurances
        }
      end
    end
  end
end
