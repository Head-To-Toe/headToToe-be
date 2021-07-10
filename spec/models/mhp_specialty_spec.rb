require 'rails_helper'

RSpec.describe MhpSpecialty, type: :model do
  describe "validations" do
    it { should validate_presence_of(:specialty_id) }
    it { should validate_presence_of(:mental_health_professional_id) }
    it { should validate_numericality_of(:specialty_id) }
    it { should validate_numericality_of(:mental_health_professional_id) }
  end

  describe "relationships" do
    it { should belong_to(:specialty) }
    it { should belong_to(:mental_health_professional) }
  end
end
