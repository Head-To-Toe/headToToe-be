class Api::V1::MedicalProfessionalsController < ApplicationController
  def index
    medical_professionals = MedicalProfessionalsFacade.get_medical_professionals(params[:type], params[:state])

    case params[:type]
    when 'doctor'
      render json: DoctorSerializer.new(medical_professionals).serializable_hash
    when 'mhp'
      render json: MhpSerializer.new(medical_professionals).serializable_hash
    end
  end

  def create
    return render status: :unauthorized if unauthorized
    
    if params[:profession].present? && params[:first_name].present? && 
      params[:last_name].present?   && params[:insurance].present?  &&
      params[:state].present?
      case params[:profession]
      when 'doctor'
        MedicalProfessionalsFacade.create_doctor_records(
          doctor_params, params[:insurance],
          params[:specialties], params[:profession]
        )
  
        render status: :created
      when 'mhp'
        MedicalProfessionalsFacade.create_mhp_records(
          mhp_params, params[:insurance],
          params[:specialties], params[:profession]
        )
  
        render status: :created
      else
        render status: :unprocessable_entity
      end
    else
      render status: :unprocessable_entity
    end
  end

  def update
    return render status: :unauthorized if unauthorized
    return render status: :unprocessable_entity unless params[:medical_professional][:id] && 
    params[:first_name] && params[:last_name]

    doctor = Doctor.find_by(first_name: params[:first_name], last_name: params[:last_name])
    mhp = MentalHealthProfessional.find_by(first_name: params[:first_name], last_name: params[:last_name])

    if doctor
      doctor.update(vetted: true)
    elsif mhp
      mhp.update(vetted: true)
    else
      render status: :not_found
    end
  end

  private

  def doctor_params
    params.permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone)
  end

  def mhp_params
    params.permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone, :cost)
  end

  def unauthorized
    return true if request.headers['api-key'] != 'aidanisthebest'

    false
  end
end
