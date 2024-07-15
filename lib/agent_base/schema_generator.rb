module AgentBase
  class SchemaGenerator
    def initialize(tool, task)
      @tool = tool
      @task = task
    end

    def generate
      task = @tool[@task]
      params = task.params
      schema = {
        type: 'function',
        function: {
          name: function_name,
          description: task.description,
          parameters: {
            type: 'object',
            properties: {}
          }
        }
      }

      params.each do |param|
        name = param[:name].to_sym
        schema[:function][:parameters][:properties][name] = {
          type: param[:type],
          description: param[:description]
        }
      end

      schema
    end

    def function_name
      "#{@task.name}_#{@tool.name}".downcase
    end
  end
end
