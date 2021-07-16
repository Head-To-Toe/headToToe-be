class MedicalProfessionals::CreateService
  class << self
    def create_doctor(doctor_params, insurances, specialties, profession)
      existing_doctor = Doctor.find_by(
        first_name: doctor_params[:first_name],
        last_name: doctor_params[:last_name]
      )
      if existing_doctor
        return false
      else
        new_doctor = Doctor.new(doctor_params)
        new_doctor.save
      end

      add_insurance(new_doctor, insurances, profession) if insurances
      add_specialties(new_doctor, specialties, profession) if specialties
      new_doctor
    end

    def create_mhp(mhp_params, insurances, specialties, profession)
      existing_mhp = MentalHealthProfessional.find_by(
        first_name: mhp_params[:first_name],
        last_name: mhp_params[:last_name]
      )

      if existing_mhp
        return false
      else
        new_mhp = MentalHealthProfessional.new(mhp_params)
        new_mhp.save
      end

      add_insurance(new_mhp, insurances, profession) if insurances
      add_specialties(new_mhp, specialties, profession) if specialties
      new_mhp
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
