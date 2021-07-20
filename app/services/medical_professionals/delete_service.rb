class MedicalProfessionals::DeleteService
  class << self
    def delete_doctor(id)
      doctor = Doctor.find_by(id: id)

      if doctor
        doctor.destroy
      else
        false
      end
    end

    def delete_mhp(id)
      mhp = MentalHealthProfessional.find_by(id: id)

      if mhp
        mhp.destroy
      else
        false
      end
    end
  end
end
