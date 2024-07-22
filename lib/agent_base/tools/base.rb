module AgentBase
  module Tools
    class Base
      def self.tasks
        instance_methods(false)
      end

      def self.name
        to_s.split('::').last
      end

      def self.[](task)
        raise 'Task not found' unless tasks.include?(task)

        Task.new(self, task)
      end
    end
  end
end
