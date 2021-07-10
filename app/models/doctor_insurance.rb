class DoctorInsurance < ApplicationRecord
  validates :insurance_id, presence: true, numericality: true
  validates :doctor_id, presence: true, numericality: true

  belongs_to :insurance
  belongs_to :doctor
end
