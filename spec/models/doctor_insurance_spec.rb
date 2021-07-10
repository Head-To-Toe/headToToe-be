require 'rails_helper'

RSpec.describe DoctorInsurance, type: :model do
  describe "validations" do
    it { should validate_presence_of(:insurance_id) }
    it { should validate_presence_of(:doctor_id) }
    it { should validate_numericality_of(:insurance_id) }
    it { should validate_numericality_of(:doctor_id) }
  end

  describe "relationships" do
    it { should belong_to(:insurance) }
    it { should belong_to(:doctor) }
  end
end
