class MedicalProfessionals::IndexService
  class << self
    def get_all_vetted_doctors(params)
      doctors = params[:state] ? Doctor.where(vetted: true, state: params[:state]) : Doctor.where(vetted: true)
      format_doctors(doctors) if doctors
    end

    def get_all_vetted_mhps(params)
      mhps = params[:state] ? MentalHealthProfessional.where(vetted: true, state: params[:state]) : MentalHealthProfessional.where(vetted: true)
      format_mhps(mhps) if mhps
    end

    def get_unvetted_doctors(params)
      doctors = params[:state] ? Doctor.where(vetted: false, state: params[:state]) : Doctor.where(vetted: false)
      format_doctors(doctors) if doctors
    end

    def get_unvetted_mhps(params)
      mhps = params[:state] ? MentalHealthProfessional.where(vetted: false, state: params[:state]) : MentalHealthProfessional.where(vetted: false)
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
          specialties: doctor.specialties,
          insurances: doctor.insurances
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
          specialties: mhp.specialties,
          insurances: mhp.insurances
        }
      end
    end
  end
end
