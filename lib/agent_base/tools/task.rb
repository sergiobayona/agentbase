module AgentBase
  class Task
    attr_reader :tool, :name

    def initialize(tool, name)
      @tool = tool
      @name = name
    end

    def description
      # get the description of the task from the tool.
      tool.new.method(name).description
    end
  end
end
