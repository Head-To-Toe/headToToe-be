class DoctorSpecialty < ApplicationRecord
  validates :specialty_id, presence: true, numericality: true
  validates :doctor_id, presence: true, numericality: true

  belongs_to :specialty
  belongs_to :doctor
end
