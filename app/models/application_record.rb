class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  class << self
    def vetted
      where(vetted: true)
    end

    def unvetted
      where(vetted: false)
    end

    def vetted_by_state(state)
      where(vetted: true, state: state)
    end

    def unvetted_by_state(state)
      where(vetted: false, state: state)
    end
  end
end
