require 'rails_helper'

RSpec.describe Insurance, type: :model do
  describe "validations" do
    it { should validate_presence_of :company }
    it { should validate_uniqueness_of :company}
  end

  describe "relationships" do
    it { should have_many(:doctor_insurances) }
    it { should have_many(:mhp_insurances) }
    it { should have_many(:doctors).through(:doctor_insurances) }
    it { should have_many(:mental_health_professionals).through(:mhp_insurances) }
  end
end

