# frozen_string_literal: true

module TudlaContracts
  module TimeSheet
    ActivitySummary = Struct.new(:task_id, :total_seconds, :notes, :remote_id, :metadata)

    # Base class for time sheet integrations
    class Base
      attr_reader :config

      def initialize(config)
        @config = config
      end

      # The core method for retrieving data.
      # @param user [User] The host application User object
      # @param date The date for which to retrieve activities
      # @param task_ids [Array<Integer>] Optional filter for specific tasks
      # @return
      def daily_activities(user, date, task_ids)
        raise NotImplementedError, "#{self.class.name} must implement #daily_activities"
      end
    end
  end
end
