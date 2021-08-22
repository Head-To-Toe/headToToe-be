class Api::V1::MedicalProfessionalsController < ApplicationController
  include Validable

  def index
    default_values(params)
    return render status: :bad_request unless valid?(params)

    resources = MedicalProfessionalsFacade.medical_professionals({ state: params[:state],
                                                                    type: params[:type], vetted: params[:vetted] })

    render json: MedicalProfessionalsSerializer.new(resources).serializable_hash
  end

  def create
    return render status: :unauthorized if unauthorized
    return render status: :unprocessable_entity unless valid_create?(params)

    case params[:profession]
    when 'doctor'
      successful_creation = MedicalProfessionalsFacade.create_doctor_records(
        doctor_params, params[:insurance],
        params[:specialties], params[:profession]
      )

    when 'mhp'
      successful_creation = MedicalProfessionalsFacade.create_mhp_records(
        mhp_params, params[:insurance],
        params[:specialties], params[:profession]
      )
    end
    successful_creation ? (render status: :created) : (render status: :conflict)
  end

  def update
    return render status: :unauthorized if unauthorized
    return render status: :bad_request unless valid_update_or_destroy?(params)

    successful_update = MedicalProfessionalsFacade.update_doctor_or_mhp_record(params[:id], params[:profession])
    return render status: :not_found unless successful_update
  end

  def destroy
    return render status: :unauthorized if unauthorized
    return render status: :bad_request unless valid_update_or_destroy?(params)

    successful_delete = MedicalProfessionalsFacade.delete_doctor_or_mhp_record(params[:id], params[:profession])

    render status: :not_found unless successful_delete
  end

  private

  def doctor_params
    params.permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone)
  end

  def mhp_params
    params.permit(:first_name, :last_name, :street, :unit, :city, :state, :zip, :phone, :cost)
  end

  def unauthorized
    return true if request.headers['api-key'] != 'aidanisthebest' # This is a joke! Will implement real auth when users/login is implemented

    false
  end
end
