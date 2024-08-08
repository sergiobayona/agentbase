module AgentBase
  class Task
    attr_reader :toolset, :name

    def initialize(toolset, name)
      @toolset = toolset
      @name = name
    end

    # get the description of the task from the toolset.
    def description
      toolset.instance_method(name).description
    end

    # returns the params of the task from the toolset.
    def params
      toolset.instance_method(name).params
    end

    def schema
      SchemaGenerator.new(toolset, name).generate
    end
  end
end
