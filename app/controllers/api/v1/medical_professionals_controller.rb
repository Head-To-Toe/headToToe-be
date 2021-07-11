class Api::V1::MedicalProfessionalsController < ApplicationController
  def index
    medical_professionals = MedicalProfessionalsFacade.depict_profession(params[:type], params[:state])

    if params[:type] == 'doctor'
      render json: DoctorSerializer.new(medical_professionals).serializable_hash
    elsif params[:type] == 'mhp'
      render json: MhpSerializer.new(medical_professionals).serializable_hash
    end
  end
end
