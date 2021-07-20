module Validable
  def valid_params?(params)
    return true if check_state(params[:state]) &&
                    check_type(params[:type]) &&
                    check_vetted(params[:vetted])
    false
  end
  
  def check_state(state)
    return state = 'all' if state.nil?
    return false if state.class != String
    states = File.read('app/support/states.rb')
    states.include?(state)
  end
  
  def check_type(type)
    return type = 'all' if type.nil?
    return false if type.class != String
    type == 'doctor' || type == 'mhp'
  end
  
  def check_vetted(vetted)
    vetted = 'true' if vetted.nil?
    ['true', 'false'].include?(vetted)
  end
end

# vetted
# state
# type