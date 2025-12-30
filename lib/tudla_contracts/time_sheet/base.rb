# frozen_string_literal: true

module TudlaContracts
  module TimeSheet
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

    # A Value Object to standardize the return data.
    class ActivitySummary
      attr_accessor :task_id, :total_seconds, :notes, :remote_id, :metadata

      def initialize(task_id:, total_seconds:, notes: nil, remote_id: nil, metadata: {})
        @task_id = task_id
        @total_seconds = total_seconds
        @notes = notes
        @remote_id = remote_id
        @metadata = metadata
      end
    end
  end
end
