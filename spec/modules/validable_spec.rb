require 'rails_helper'
include Validable

RSpec.describe 'Validable' do
  context 'check_state(state)' do
    it 'Sets default value if none is provided' do
      expect(check_state(nil)).to eq('all')
    end

    it 'returns true if state is valid' do
      expect(check_state('Colorado')).to eq(true)
      expect(check_state('Ohio')).to eq(true)
    end

    it 'returns false if an invalid state is passed' do
      expect(check_state('Pudding')).to eq(false)
    end

    it 'returns false if it is not a string' do
      expect(check_state(0)).to eq(false)
      expect(check_state(12)).to eq(false)
      expect(check_state(Array)).to eq(false)
    end
  end
end

