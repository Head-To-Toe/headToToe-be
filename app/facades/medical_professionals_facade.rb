class MedicalProfessionalsFacade
  class << self
    def get_medical_professionals(params)
      case params[:type]
      when 'doctor'
        doctors = MedicalProfessionals::IndexService.get_all_vetted_doctors(params)
      when 'mhp'
        mhps = MedicalProfessionals::IndexService.get_all_vetted_mhps(params)
      else
        doctors = MedicalProfessionals::IndexService.get_all_vetted_doctors(params)
        mhps = MedicalProfessionals::IndexService.get_all_vetted_mhps(params)
      end
      OpenStruct.new(id: nil, doctors: doctors, mhps: mhps)
    end

    def get_unvetted_professionals(params)
      if params[:type].nil?
        doctors = MedicalProfessionals::IndexService.get_unvetted_doctors(params)
        mhps = MedicalProfessionals::IndexService.get_unvetted_mhps(params)
      elsif params[:type] == 'doctor'
        doctors = MedicalProfessionals::IndexService.get_unvetted_doctors(params)
      elsif params[:type] == 'mhp'
        mhps = MedicalProfessionals::IndexService.get_unvetted_mhps(params)
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
