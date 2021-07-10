class MhpInsurance < ApplicationRecord
  validates :insurance_id, presence: true, numericality: true
  validates :mental_health_professional_id, presence: true, numericality: true

  belongs_to :insurance
  belongs_to :mental_health_professional
end
