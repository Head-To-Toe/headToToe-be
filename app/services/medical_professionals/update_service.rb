class MedicalProfessionals::UpdateService
  class << self
    def update_doctor_or_mhp(first_name, last_name)
      doctor = Doctor.find_by(first_name: first_name, last_name: last_name)
      mhp = MentalHealthProfessional.find_by(first_name: first_name, last_name: last_name)

      if doctor
        doctor.update(vetted: true)
      elsif mhp
        mhp.update(vetted: true)
      end
    end
  end
end
