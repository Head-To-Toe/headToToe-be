class MedicalProfessionalsFacade
  class << self
    def get_medical_professionals(params)
      case params[:type]
      when 'doctor'
        care_givers = MedicalProfessionals::IndexService.get_all_vetted_doctors(params)
      when 'mhp'
        care_givers = MedicalProfessionals::IndexService.get_all_vetted_mhps(params)
      end
      OpenStruct.new(id: nil, list: care_givers)
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
  end
end
