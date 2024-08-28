module AgentBase
  class Tool
    attr_reader :agent, :name

    def initialize(agent, name)
      @agent = agent
      @name = name
    end

    def self.tasks
      # return a hash of all for the tool. the key is the task name and the value is the task class.
      instance_methods(false).each_with_object({}) do |task, hash|
        hash[task] = Task.new(self, task)
      end
    end

    def self.[](task)
      raise 'Task not found' unless tasks.include?(task)

      Task.new(self, task)
    end

    def run
      raise NotImplementedError, 'You must implement the run method'
    end
  end
end
