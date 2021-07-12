class Api::V1::AddProfessionalController < ApplicationController
  def create
    return render status: :unauthorized if unauthorized
    case params[:profession]
    when 'doctor'
      create_doctor
    when 'mhp'
      create_mhp
    end
  end

  private

  def create_doctor
    new_doctor = Doctor.new(doctor_params)
    if new_doctor.save
      set_insurance(new_doctor)
      set_specialties(new_doctor)
      render status: :created
    else
      render status: :bad_request
    end
  end

  def create_mhp
    new_mhp = MentalHealthProfessional.new(mhp_params)
    if new_mhp.save
      set_insurance(new_mhp)
      set_specialties(new_mhp)
      render status: :created
    else
      render status: :bad_request
    end
  end
  
  def set_insurance(professional)
    params[:insurance].each do |insurance|
      i = Insurance.find_or_create_by(company: insurance)
      case params[:profession]
      when 'doctor'
        DoctorInsurance.create(doctor_id: professional.id, insurance_id: i.id)
      when 'mhp'
        MhpInsurance.create(mental_health_professional_id: professional.id, insurance_id: i.id)
      end
    end
  end
  
  def set_specialties(professional)
    params[:specialties].each do |specialty|
      i = Specialty.find_or_create_by(name: specialty)
      case params[:profession]
      when 'doctor'
        DoctorSpecialty.create(doctor_id: professional.id, specialty_id: i.id)
      when 'mhp'
        MhpSpecialty.create(mental_health_professional_id: professional.id, specialty_id: i.id)
      end
    end
  end

  def doctor_params
    params.require(:add_professional)
    .permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone)
  end

  def mhp_params
    params.require(:add_professional)
    .permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone, :cost)
  end

  def unauthorized
    return true if request.headers["api-key"] != 'aidanisthebest'
    false
  end
end
