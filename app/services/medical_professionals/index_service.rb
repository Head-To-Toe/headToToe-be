class MedicalProfessionals::IndexService
  class << self
    def vetted_doctors(params)
      doctors = params[:state] == 'all' ? Doctor.vetted : Doctor.vetted_by_state(params[:state])
      format_doctors(doctors) if doctors
    end

    def vetted_mhps(params)
      mhps = params[:state] == 'all' ? MentalHealthProfessional.vetted : MentalHealthProfessional.vetted_by_state(params[:state])
      format_mhps(mhps) if mhps
    end

    def unvetted_doctors(params)
      doctors = params[:state] == 'all' ? Doctor.unvetted : Doctor.unvetted_by_state(params[:state])
      format_doctors(doctors) if doctors
    end

    def unvetted_mhps(params)
      mhps = params[:state] == 'all' ? MentalHealthProfessional.unvetted : MentalHealthProfessional.unvetted_by_state(params[:state])
      format_mhps(mhps) if mhps
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
          specialties: doctor.specialties.map { |specialty| specialty.name },
          insurances: doctor.insurances.map { |insurance| insurance.company }
        }
      end
    end

    def format_mhps(mental_health_professionals)
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
          specialties: mhp.specialties.map { |specialty| specialty.name },
          insurances: mhp.insurances.map { |insurance| insurance.company }
        }
      end
    end
  end
end
