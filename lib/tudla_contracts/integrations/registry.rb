module Tudla
  module Integrations
    # Shared class for registering and looking up integrations
    class Registry
      # Thread-safe storage for registered integrations
      @integrations = {}

      class << self
        # Method called by gems to register themselves
        def register(name, provider_class:, config_class:)
          @integrations[name.to_s] = {
            provider_class: provider_class,
            config_class: config_class
          }
        end

        # Used by the Host App to look up a specific provider
        def find(name)
          entry = @integrations[name.to_s]
          raise ArgumentError, "Unknown integration: #{name}" unless entry

          entry[:provider_class]
        end

        # Used by the Host App to find the config class for polymorphic associations
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
