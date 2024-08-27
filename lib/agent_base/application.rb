# frozen_string_literal: true

require_relative 'agent'
module AgentBase
  class Application
    attr_reader :config, :agents

    def initialize(config_file = nil)
      @config = Configuration.new
      @agents = Agents.new
      load_agents
      register_agents
      rescue StandardError => e
        raise Error, "Failed to initialize application: #{e.message}"
    end

    def load_agents
      Dir.glob(File.join(@config.root_path, @config.agents_path, '**', @config.agent_file_name)).each do |file|
        require file
      end
    rescue LoadError => e
      raise Error, "Failed to load agent files: #{e.message}"
    end

    def register_agents
      available_agents.each do |agent_class|
        module_name = ActiveSupport::Inflector.deconstantize(agent_class.to_s)
        agent_instance = agent_class.new(config, module_name)
        @agents << agent_instance
      rescue AgentInitializationError, ToolLoadError => e
        log_error("Failed to register agent #{agent_class}: #{e.message}")
      end
    end

    private

    def available_agents
      Agent.descendants
    end

    def log_error(message)
      # Use a proper logging mechanism here, e.g., Rails.logger or a custom logger
      puts "[ERROR] #{message}"
    end

    class Agents
      def initialize
        @agents = []
      end

      def <<(agent)
        define_singleton_method(agent.name.underscore) do
          agent
        end

        @agents << agent
      end

      def all
        @agents
      end

      def each(&block)
        @agents.each(&block)
      end

      def map(&block)
        @agents.map(&block)
      end

      def size
        @agents.size
      end

      def names
        @agents.map { |agent| agent.class.name.underscore }
      end
    end
  end
end
