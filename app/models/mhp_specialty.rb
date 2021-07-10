class MhpSpecialty < ApplicationRecord
  validates :specialty_id, presence: true, numericality: true
  validates :mental_health_professional_id, presence: true, numericality: true

  belongs_to :specialty
  belongs_to :mental_health_professional
end
