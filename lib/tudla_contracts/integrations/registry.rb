# frozen_string_literal: true

module TudlaContracts
  module Integrations
    # Shared class for registering and looking up integrations
    class Registry
      # Thread-safe storage for registered integrations
      @integrations = {}
      # Thread-safe storage for registered view components
      @view_slots = {}

      VALID_TYPES = %w[time_sheet].freeze

      class << self
        # Method called by gems to register themselves
        # @param name [String, Symbol] Unique identifier for the integration
        # @param type [String, Symbol] Integration type (e.g., :time_sheet)
        # @param provider_class [String] Fully qualified class name of the provider
        # @param config_class [String] Fully qualified class name of the config
        def register(name, type:, provider_class:, config_class:)
          @integrations[name.to_s] = {
            type: type.to_s,
            provider_class: provider_class.to_s,
            config_class: config_class.to_s
          }
        end

        # Reset the registry
        def reset!
          @integrations = {}
          @view_slots = {}
        end

        # Method called by gems to register view components for slots
        # @param slot [String, Symbol] Slot name
        # @param view_component_class [Class] The view component class
        def register_view_for_slot(slot, view_component_class)
          raise ArgumentError, "view_component_class must be a Class" unless view_component_class.is_a?(Class)

          @view_slots[slot.to_s] ||= []
          @view_slots[slot.to_s] << view_component_class
        end

        # Used by the Host App to look up view components for a specific slot
        # @param slot [String, Symbol] Slot name
        # @return [Array<String>] Array of fully qualified view component class names
        def views_for_slot(slot)
          @view_slots[slot.to_s] || []
        end

        # Used by the Host App to look up all registered slots
        def registered_slots
          @view_slots.keys
        end

        # Used by the Host App to look up a specific provider
        # @param name [String, Symbol] Integration name
        # @return [String] Fully qualified provider class name
        def find(name)
          entry = @integrations[name.to_s]
          raise ArgumentError, "Unknown integration: #{name}" unless entry

          entry[:provider_class]
        end

        # Used by the Host App to look up all integrations of a specific type
        def all_of_type(type)
          @integrations.select { |_, v| v[:type] == type.to_s }.values
        end

        # Used by the Host App to find the config class for polymorphic associations
        # @param name [String, Symbol] Integration name
        # @return [String, nil] Fully qualified config class name or nil if not found
        def config_class_for(name)
          entry = @integrations[name.to_s]
          return nil unless entry

          entry[:config_class]
        end

        # Used to populate UI dropdowns
        def available_providers
          @integrations.keys
        end
      end
    end
  end
end
