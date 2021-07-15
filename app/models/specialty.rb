class Specialty < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :doctor_specialties, dependent: :destroy
  has_many :mhp_specialties, dependent: :destroy
  has_many :doctors, through: :doctor_specialties
  has_many :mental_health_professionals, through: :mhp_specialties
end
