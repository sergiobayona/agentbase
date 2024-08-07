module AgentBase
  class SchemaGenerator
    attr_reader :toolset, :task

    def initialize(toolset, task)
      @toolset = toolset
      @task = task
    end

    def generate
      task_details = toolset[task]
      schema = {
        type: 'function',
        function: {
          name: function_name,
          description: task_details.description,
          parameters: generate_parameters_schema(task_details.params)
        }
      }
    end

    private

    def generate_parameters_schema(params)
      raise ArgumentError, 'Params must be an array' unless params.is_a?(Array)

      params.each_with_object(type: 'object', properties: {}, required: []) do |param, schema|
        name = param[:name].to_sym
        schema[:properties][name] = {
          type: param[:type],
          description: param[:description]
        }
        schema[:required] << name.to_s # if param[:required]
        schema
      end
    end

    def function_name
      "#{task.name}_#{toolset.name}".downcase
    end
  end
end
