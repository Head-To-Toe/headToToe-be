class UnvettedProfessionalsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :doctors, :mhps
end
