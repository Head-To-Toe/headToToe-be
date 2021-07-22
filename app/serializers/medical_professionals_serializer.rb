class MedicalProfessionalsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :doctors, :mhps
end
