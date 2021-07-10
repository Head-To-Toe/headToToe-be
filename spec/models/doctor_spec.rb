require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:vetted)}
  end

  describe "relationships" do
    it { should have_many(:doctor_specialties) }
    it { should have_many(:doctor_insurances) }
    it { should have_many(:specialties).through(:doctor_specialties) }
    it { should have_many(:insurances).through(:doctor_insurances) }
  end
end
