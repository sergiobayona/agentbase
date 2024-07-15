require_relative '../schema_generator'
module AgentBase
  class Task
    attr_reader :tool, :name

    def initialize(tool, name)
      @tool = tool
      @name = name
    end

    def description
      # get the description of the task from the tool.
      tool.instance_method(name).description
    end

    def params
      # get the params of the task from the tool.
      tool.instance_method(name).params
    end

    def schema
      SchemaGenerator.new(tool, name).generate
    end
  end
end
