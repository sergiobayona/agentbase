require_relative '../renderable'
module AgentBase
  module Tools
    class Base
      include AgentBase::Renderable

      def self.tasks
        self.instance_methods(false)
      end

      def self.name
        self.to_s.split('::').last
      end

      def self.[](task)
        if tasks.include?(task)
          Task.new(self, task)
        else
          raise "Task not found"
        end
      end
    end
  end
end
