class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  class << self
    def get_vetted
      where(vetted: true)
    end

    def get_unvetted
      where(vetted: false)
    end

    def get_vetted_by_state(state)
      where(vetted: true, state: state)
    end

    def get_unvetted_by_state(state)
      where(vetted: false, state: state)
    end
  end
end
