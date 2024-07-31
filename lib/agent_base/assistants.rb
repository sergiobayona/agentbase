require_relative 'assistant'
module AgentBase
  class Assistants
    attr_reader :config

    def initialize(config)
      @config = config
      load_assistants
    end

    def load_assistants
      Dir.glob(Rails.root.join(config.assistants_path, '**', config.assistant_file_name)).each do |file|
        require file
      end
    end

    def assistants
      Assistant.descendants
    end

    alias all assistants

    def start_assistants
      assistants.each do |assistant|
        assistant.new(config)
      end
    end

    # use method_missing to define a method for each assistant
    # that returns the instance of the assistant.
    # This allows us to call the assistant by name.
    def method_missing(method_name, *args, &block)
      assistant = Assistant.descendants.find { |a| a.name == method_name.to_s }
      return assistant.new(config) if assistant

      super
    end
  end
end
