require 'rails_helper'

RSpec.describe MhpInsurance, type: :model do
  describe "validations" do
    it { should validate_presence_of(:insurance_id) }
    it { should validate_presence_of(:mental_health_professional_id) }
    it { should validate_numericality_of(:insurance_id) }
    it { should validate_numericality_of(:mental_health_professional_id) }
  end

  describe "relationships" do
    it { should belong_to(:insurance) }
    it { should belong_to(:mental_health_professional) }
  end
end
