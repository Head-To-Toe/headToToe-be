class Api::V1::AddProfessionalController < ApplicationController
  def create
    key = request.headers["api-key"]
    case params[:profession]
    when 'doctor'
      create_doctor
    when 'mhp'
      create_mhp
    end
  end

  private

  def create_doctor
    doctor = doctor_params 
    new_doctor = Doctor.new(doctor)
    if new_doctor.save
      set_insurance(new_doctor)
      set_specialties(new_doctor)
      render status: :created
    else
      render status: :bad_request
    end
  end

  def create_mhp
    mhp = mhp_params 
    new_mhp = MentalHealthProfessional.new(mhp)
    if new_mhp.save
      render status: :created
    else
      render status: :bad_request
    end
  end

  def doctor_params
    params.require(:add_professional).permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone)
  end

  def mhp_params
    params.require(:add_professional).permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone, :cost)
  end

  def set_insurance(professional)
    params[:insurance].each do |insurance|
      i = Insurance.find_or_create_by(company: insurance)
      case params[:profession]
      when 'doctor'
        DoctorInsurance.create(doctor_id: professional.id, insurance_id: i.id)
      when 'mhp'
        MhpInsurance.create(mhp_id: professional.id, insurance_id: i.id)
      end
    end
  end

  def set_specialties(doctor)
    params[:specialties].each do |specialty|
      i = Specialty.find_or_create_by(name: specialty)
      DoctorSpecialty.create(doctor_id: doctor.id, specialty_id: i.id)
    end
  end
end
