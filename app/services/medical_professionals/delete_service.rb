class MedicalProfessionals::DeleteService
  class << self
    def delete_doctor_or_mhp(first_name, last_name)
      doctor = Doctor.find_by(first_name: first_name, last_name: last_name)
      mhp = MentalHealthProfessional.find_by(first_name: first_name, last_name: last_name)

      if doctor
        doctor.delete
      elsif mhp
        mhp.delete
      end
    end
  end
end