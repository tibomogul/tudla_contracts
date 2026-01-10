# frozen_string_literal: true

module TudlaContracts
  module Integrations
    User = Struct.new(:id, :name, :email)
    Task = Struct.new(:id, :name, :project_id)
    Project = Struct.new(:id, :name)
    # Host application interface for TudlaContracts
    class HostInterface
      # Returns an array of tasks available to the user
      # @param user [User] The host application User object
      # @return [Array<Task>]
      def available_tasks_for_user(user)
        raise NotImplementedError, "#{self.class.name} must implement #avaliable_tasks_for_user"
      end
    end
  end
end
