module Validable
  def valid_params?(params)
    set_defaults(params)
    return true if check_state(params[:state]) &&
                    check_type(params[:type]) &&
                    check_vetted(params[:vetted])
    false
  end

  def set_defaults(params)
    params[:state] = 'all' if params[:state].nil?
    params[:type] = 'all' if params[:type].nil?
    params[:vetted] = 'true' if params[:vetted].nil?
  end
  
  def check_state(state)
    return true if state == 'all'
    return false if state.class != String
    states = File.read('app/support/states.rb')
    states.include?(state)
  end
  
  def check_type(type)
    return true if type == 'all'
    return false if type.class != String
    type == 'doctor' || type == 'mhp' || type == 'all'
  end
  
  def check_vetted(vetted)
    ['true', 'false'].include?(vetted)
  end
end
