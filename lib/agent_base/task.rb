module AgentBase
  class Task
    attr_reader :tool, :name

    def initialize(tool, name)
      @tool = tool
      @name = name
    end

    # get the description of the task from the tool.
    def description
      tool.instance_method(name).description
    end

    # returns the params of the task from the tool.
    def params
      tool.instance_method(name).params
    end

    def schema
      SchemaGenerator.new(tool, name).generate
    end
  end
end
