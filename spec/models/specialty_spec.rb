require 'rails_helper'

RSpec.describe Specialty, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name}
  end

  describe "relationships" do
    it { should have_many(:doctor_specialties) }
    it { should have_many(:mhp_specialties) }
    it { should have_many(:doctors).through(:doctor_specialties) }
    it { should have_many(:mental_health_professionals).through(:mhp_specialties) }
  end
end
