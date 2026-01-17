# frozen_string_literal: true

module TudlaContracts
  module Integrations
    module ViewDefinitions
      # Base class for all view definitions
      # Subclasses must implement the #visible? method
      class Base
        attr_reader :id, :label, :component_class, :priority, :condition

        def initialize(id:, label:, component_class:, priority: 10, if: nil)
          @id = id
          @label = label
          @component_class = component_class
          @priority = priority
          # Capture the conditional logic (lambda/proc)
          @condition = binding.local_variable_get(:if)
        end

        # Helper to check visibility within a specific context
        def visible?(context, *args)
          return true if @condition.nil?

          # Execute the condition in the context of the view (context)
          context.instance_exec(*args, &@condition)
        end
      end
    end
  end
end
