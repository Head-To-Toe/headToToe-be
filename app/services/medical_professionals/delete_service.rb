class MedicalProfessionals::DeleteService
  class << self
    def delete_doctor(id)
      doctor = Doctor.find_by(id: id)

      if doctor
        doctor.delete
      else
        false
      end
    end

    def delete_mhp(id)
      mhp = MentalHealthProfessional.find_by(id: id)

      if mhp
        mhp.delete
      else
        false
      end
    end
  end
end
