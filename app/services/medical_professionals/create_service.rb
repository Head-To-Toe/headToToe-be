class MedicalProfessionals::CreateService
  class << self
    def create_doctor(doctor_params, insurances, specialties, profession)
      new_doctor = Doctor.new(doctor_params)
      if new_doctor.save
        add_insurance(new_doctor, insurances, profession)
        add_specialties(new_doctor, specialties, profession)
      end
    end

    def create_mhp(mhp_params, insurances, specialties, profession)
      new_mhp = MentalHealthProfessional.new(mhp_params)
      if new_mhp.save
        add_insurance(new_mhp, insurances, profession)
        add_specialties(new_mhp, specialties, profession)
      end
    end

    def add_insurance(professional, insurances, profession)
      insurances.each do |insurance|
        i = Insurance.find_or_create_by(company: insurance)
        case profession
        when 'doctor'
          DoctorInsurance.create(doctor_id: professional.id, insurance_id: i.id)
        when 'mhp'
          MhpInsurance.create(mental_health_professional_id: professional.id, insurance_id: i.id)
        end
      end
    end

    def add_specialties(professional, specialties, profession)
      specialties.each do |specialty|
        i = Specialty.find_or_create_by(name: specialty)
        case profession
        when 'doctor'
          DoctorSpecialty.create(doctor_id: professional.id, specialty_id: i.id)
        when 'mhp'
          MhpSpecialty.create(mental_health_professional_id: professional.id, specialty_id: i.id)
        end
      end
    end
  end
end