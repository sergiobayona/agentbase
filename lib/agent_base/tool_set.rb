require 'active_support'
module AgentBase
  class ToolSet
    def initialize(tool_names, agent)
      @tool_names = tool_names
      @tools = []
      @agent = agent
      register_tools
    end

    attr_reader :tools

    def self.tasks
      # return a hash of all for the tool. the key is the task name and the value is the task class.
      instance_methods(false).each_with_object({}) do |task, hash|
        hash[task] = Task.new(self, task)
      end
    end

    def self.name
      to_s.split('::').last
    end

    def names
      @tool_names
    end

    def self.[](task)
      raise 'Task not found' unless tasks.include?(task)

      Task.new(self, task)
    end

    def register_tools
      @tool_names.each do |tool|
        define_singleton_method(tool) do
          self.class.const_get("#{@agent.module_name}::#{tool.capitalize}")
        end
      end
    end
  end
end
