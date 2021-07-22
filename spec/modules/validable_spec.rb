require 'rails_helper'
include Validable

RSpec.describe 'Validable' do
  context 'valid_params?' do
    it 'Accepts all valid params' do
      params = {state: 'Colorado', type: 'mhp', vetted: 'true'}

      expect(valid_params?(params)).to eq(true)
    end

    it 'Accepts valid state & type, vetted nil, sets default' do
      params = {state: 'Colorado', type: 'mhp'}
      default_values(params)

      expect(valid_params?(params)).to eq(true)

      expect(params[:state]).to eq('Colorado')
      expect(params[:type]).to eq('mhp')
      expect(params[:vetted]).to eq('true')
    end

    it 'Accepts valid state & vetted, type nil, sets default' do
      params = {state: 'Colorado', vetted: 'false'}
      default_values(params)

      expect(valid_params?(params)).to eq(true)

      expect(params[:state]).to eq('Colorado')
      expect(params[:type]).to eq('all')
      expect(params[:vetted]).to eq('false')
    end

    it 'Accepts valid type & vetted, state nil, sets default' do
      params = {type: 'doctor', vetted: 'false'}
      default_values(params)

      expect(valid_params?(params)).to eq(true)

      expect(params[:state]).to eq('all')
      expect(params[:type]).to eq('doctor')
      expect(params[:vetted]).to eq('false')
    end

    it 'Accepts no params, sets defaults' do
      params = {type: 'doctor', vetted: 'false'}
      default_values(params)
      
      expect(valid_params?(params)).to eq(true)

      expect(params[:state]).to eq('all')
      expect(params[:type]).to eq('doctor')
      expect(params[:vetted]).to eq('false')
    end
  end

  context 'default_values' do
    it 'sets default values if params are not provided' do
      params = {}

      default_values(params)

      expect(params[:state]).to eq('all')
      expect(params[:type]).to eq('all')
      expect(params[:vetted]).to eq('true')
    end
  end

  context 'check_state(state)' do
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

  context 'check_type(type)' do
    it 'returns true if type is valid' do
      expect(check_type('doctor')).to eq(true)
      expect(check_type('mhp')).to eq(true)
    end

    it 'returns false if an invalid type is passed' do
      expect(check_type('Pudding')).to eq(false)
    end

    it 'returns false if it is not a string' do
      expect(check_type(0)).to eq(false)
      expect(check_type(12)).to eq(false)
      expect(check_type(Array)).to eq(false)
    end
  end

  context 'check_vetted(vetted)' do
    it 'returns true if vetted is valid' do
      expect(check_vetted('false')).to eq(true)
      expect(check_vetted('true')).to eq(true)
    end

    it 'returns false if an invalid vetted is passed' do
      expect(check_vetted('Pudding')).to eq(false)
    end

    it 'returns false if it is not a string' do
      expect(check_vetted(0)).to eq(false)
      expect(check_vetted(12)).to eq(false)
      expect(check_vetted(Array)).to eq(false)
    end
  end
end

