module Validable
  def default_values(params)
    params[:state] = 'all' if params[:state].nil?
    params[:type] = 'all' if params[:type].nil?
    params[:vetted] = 'true' if params[:vetted].nil?
  end

  def valid_params?(params)
    return true if check_state(params[:state]) &&
                    check_type(params[:type]) &&
                    check_vetted(params[:vetted])

    false
  end

  def check_state(state)
    return true if state == 'all'
    return false if state.class != String

    states = JSON.parse(File.read('app/support/states.json'))
    states.any? do |_abbreviated, full|
      state == full
    end
  end

  def check_type(type)
    return true if type == 'all'
    return false if type.class != String

    %w[doctor mhp all].include?(type)
  end

  def check_vetted(vetted)
    %w[true false].include?(vetted)
  end

  def valid_create_params?(params)
    return false if params[:profession] != 'doctor' && params[:profession] != 'mhp'
    return false if params[:first_name].class != String
    return false if params[:first_name].empty? == true
    return false if params[:last_name].class != String
    return false if params[:last_name].empty? == true
    return false if params[:insurance].class != Array
    true
  end

  def valid_update_or_destroy?(params)
    return false if params[:profession] != 'doctor' && params[:profession] != 'mhp'
    return false if params[:id].class != String
    return false if params[:id].to_i.class != Integer
    return false if params[:id].to_i == 0
    true
  end
end
