module AgentBase
  class SchemaGenerator
    def initialize(tool, name)
      @tool = tool
      @name = name
    end

    def generate
      task = @tool.instance_method(@name)
      params = task.parameters
      schema = { type: 'object', properties: {} }
      params.each do |param|
        schema[:properties][param[1]] = { type: param[0].to_s }
      end
      schema
    end
  end
end
