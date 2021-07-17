class Api::V1::MedicalProfessionalsController < ApplicationController
  def index
    if params[:vetted].blank? || params[:vetted] == true
      medical_professionals = MedicalProfessionalsFacade.get_medical_professionals({ type: params[:type],
                                                                                     state: params[:state] })

      render json: VettedProfessionalsSerializer.new(medical_professionals).serializable_hash
    elsif params[:vetted] == 'false'
      unvetted_professionals = MedicalProfessionalsFacade.get_unvetted_professionals({ type: params[:type],
                                                                                       state: params[:state] })
      render json: UnvettedProfessionalsSerializer.new(unvetted_professionals).serializable_hash
    end
  end

  def create
    return render status: :unauthorized if unauthorized

    if params[:profession].present? && params[:first_name].present? &&
       params[:last_name].present? && params[:insurance].present? &&
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
    return render status: :unprocessable_entity unless params[:id] && params[:profession]
    return render status: :not_found unless params[:profession] == 'doctor' || params[:profession] == 'mhp'

    completed_update = MedicalProfessionalsFacade.update_doctor_or_mhp_record(params[:id], params[:profession])
    return render status: :not_found unless completed_update
  end

  def destroy
    return render status: :unauthorized if unauthorized
    return render status: :unprocessable_entity unless params[:id] && params[:profession]
    return render status: :not_found unless params[:profession] == 'doctor' || params[:profession] == 'mhp'

    completed_delete = MedicalProfessionalsFacade.delete_doctor_or_mhp_record(params[:id], params[:profession])

    render status: :not_found unless completed_delete
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
