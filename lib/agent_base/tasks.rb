module AgentBase
  Task = Data.define(:description, :options)

  class Tasks
    attr_reader :tasks

    def initialize
      @tasks = {}
    end

    def task(description, **options)
      raise ArgumentError, 'description must be a string' unless description.is_a?(String)
      raise ArgumentError, 'options must be a hash' unless options.is_a?(Hash)

      name = description.squeeze.downcase.gsub(' ', '_')
      @tasks[name] = Task.new(description:, options:)
    end

    class << self
      attr_accessor :source

      def draw(&block)
        task_definitions = new
        task_definitions.instance_eval(&block)
        task_definitions
      end
    end
  end
end
