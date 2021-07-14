class MedicalProfessionals::UpdateService
  class << self
    def update_doctor(id)
      doctor = Doctor.find_by(id: id)

      if doctor
        doctor.update(vetted: true)
      else
        false
      end
    end

    def update_mhp(id)
      mhp = MentalHealthProfessional.find_by(id: id)

      if mhp
        mhp.update(vetted: true)
      else
        false
      end
    end
  end
end
