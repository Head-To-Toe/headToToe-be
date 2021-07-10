require 'rails_helper'

RSpec.describe MentalHealthProfessional, type: :model do
  describe "validations" do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
    it { should validate_presence_of :state}
    it { should validate_presence_of :vetted}
  end

  describe "relationships" do
    it { should have_many(:mhp_specialties) }
    it { should have_many(:mhp_insurances) }
    it { should have_many(:specialties).through(:mhp_specialties) }
    it { should have_many(:insurances).through(:mhp_insurances) }
  end
end
