require 'active_support'
module AgentBase
  module Tools
    class Base
      def initialize
        AgentBase::Tools.load
        # dynamically define getter methods for each tool
        all.each do |tool|
          define_singleton_method(tool.name.downcase.to_sym) do
            AgentBase::Tools.const_get(tool.name.to_sym)
          end
        end
      end

      def all
        self.class.descendants
      end

      def self.tasks
        # return a hash of all for the tool. the key is the task name and the value is the task class.
        instance_methods(false).each_with_object({}) do |task, hash|
          hash[task] = Task.new(self, task)
        end
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
