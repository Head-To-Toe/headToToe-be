class Doctor < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :state, presence: true
  validates :vetted, inclusion: { in: [true, false] }

  has_many :doctor_insurances
  has_many :doctor_specialties
  has_many :specialties, through: :doctor_specialties
  has_many :insurances, through: :doctor_insurances
end
