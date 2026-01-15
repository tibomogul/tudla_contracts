# frozen_string_literal: true

module TudlaContracts
  module Integrations
    module ViewDefinitions
      # Base class for all view definitions
      # Subclasses must implement the #visible? method
      class Base
        def visible?(_context, *_args)
          raise NotImplementedError, "#{self.class} must implement #visible?"
        end
      end
    end
  end
end
