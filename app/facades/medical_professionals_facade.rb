class MedicalProfessionalsFacade
  class << self
    def medical_professionals(params)
      case params[:vetted]
      when 'true'
        vetted_professionals({ type: params[:type], state: params[:state] })
      when 'false'
        unvetted_professionals({ type: params[:type], state: params[:state] })
      end
    end

    def vetted_professionals(params)
      case params[:type]
      when 'doctor'
        doctors = MedicalProfessionals::IndexService.vetted_doctors(params)
      when 'mhp'
        mhps = MedicalProfessionals::IndexService.vetted_mhps(params)
      else
        doctors = MedicalProfessionals::IndexService.vetted_doctors(params)
        mhps = MedicalProfessionals::IndexService.vetted_mhps(params)
      end
      OpenStruct.new(id: nil, doctors: doctors, mhps: mhps)
    end

    def unvetted_professionals(params)
      case params[:type]
      when 'all'
        doctors = MedicalProfessionals::IndexService.unvetted_doctors(params)
        mhps = MedicalProfessionals::IndexService.unvetted_mhps(params)
      when 'doctor'
        doctors = MedicalProfessionals::IndexService.unvetted_doctors(params)
      when 'mhp'
        mhps = MedicalProfessionals::IndexService.unvetted_mhps(params)
      end
      OpenStruct.new(id: nil, doctors: doctors, mhps: mhps)
    end

    def create_doctor_records(doctor_params, insurances, specialties, profession)
      MedicalProfessionals::CreateService.create_doctor(doctor_params, insurances, specialties, profession)
    end

    def create_mhp_records(mhp_params, insurances, specialties, profession)
      MedicalProfessionals::CreateService.create_mhp(mhp_params, insurances, specialties, profession)
    end

    def update_doctor_or_mhp_record(id, profession)
      case profession
      when 'doctor'
        MedicalProfessionals::UpdateService.update_doctor(id)
      when 'mhp'
        MedicalProfessionals::UpdateService.update_mhp(id)
      end
    end

    def delete_doctor_or_mhp_record(id, profession)
      case profession
      when 'doctor'
        MedicalProfessionals::DeleteService.delete_doctor(id)
      when 'mhp'
        MedicalProfessionals::DeleteService.delete_mhp(id)
      end
    end
  end
end
