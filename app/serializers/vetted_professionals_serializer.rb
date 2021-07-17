class VettedProfessionalsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :doctors, :mhps
end
