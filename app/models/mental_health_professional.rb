class MentalHealthProfessional < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :state, presence: true
  validates :vetted, inclusion: { in: [true, false] }

  has_many :mhp_insurances, dependent: :destroy
  has_many :mhp_specialties, dependent: :destroy
  has_many :specialties, through: :mhp_specialties
  has_many :insurances, through: :mhp_insurances
end
