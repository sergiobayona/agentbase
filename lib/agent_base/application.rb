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


    private

    def register_agents
      Agent.descendants.each do |agent_class|
        @agents << agent_class.new(config)
      rescue AgentInitializationError, ToolLoadError => e
        log_error("Failed to register agent #{agent_class}: #{e.message}")
      end
    end

    def load_agents
      Dir.glob(File.join(@config.root_path, @config.agents_path, '**', "*.rb")).each do |file|
        require file
      end
    rescue LoadError => e
      raise Error, "Failed to load agent files: #{e.message}"
    end

    def log_error(message)
      # Use a proper logging mechanism here, e.g., Rails.logger or a custom logger
      puts "[ERROR] #{message}"
    end

    class Agents
      include Enumerable

      def initialize
        @agents = []
      end

      def <<(agent)
        define_singleton_method(agent.name.underscore) { agent }
        @agents << agent
      end

      def each(&block)
        @agents.each(&block)
      end

      def names
        map { |agent| agent.class.name.underscore }
      end

      def size
        @agents.size
      end

      def all
        @agents
      end

    end
  end
end
