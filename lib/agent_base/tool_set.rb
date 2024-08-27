require 'active_support'

module AgentBase
  class ToolSet
    attr_reader :tools

    def initialize(tool_names, agent)
      @tool_names = tool_names
      @agent = agent
      @tools = []
      register_tools
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

    def names
      @tool_names
    end

    def self.[](task)
      raise 'Task not found' unless tasks.include?(task)

      Task.new(self, task)
    end

    def register_tools
      @tool_names.each do |tool|
        register_tool(tool)
      end
    end

    private

    def register_tool(tool)
      tool_class = self.class.const_get("#{@agent.module_name}::#{tool.capitalize}")
      @tools << tool_class
      define_singleton_method(tool) { tool_class }
      rescue NameError => e
        raise ToolLoadError, "Failed to register tool #{tool}: #{e.message}"
    end
  end
end
