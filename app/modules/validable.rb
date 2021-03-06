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
end
