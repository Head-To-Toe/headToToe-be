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
end
