class Insurance < ApplicationRecord
  validates :company, presence: true, uniqueness: true

  has_many :doctor_insurances, dependent: :destroy
  has_many :mhp_insurances, dependent: :destroy
  has_many :doctors, through: :doctor_insurances
  has_many :mental_health_professionals, through: :mhp_insurances
end
