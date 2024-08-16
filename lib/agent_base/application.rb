# frozen_string_literal: true

require_relative 'agent'
module AgentBase

  class Application
    attr_accessor :config, :agents

    def initialize(config_file = nil)
      @config = Configuration.new({ config_file: })
      load_agents
      register_agents
    end

    def load_agents
      Dir.glob(Rails.root.join(config.agents_path, '**', config.agent_file_name)).each do |file|
        require file
      end
    end

    def register_agents
      @agents = Agents.new

      _agents.each do |agent|
        agent_instance = agent.new(config)
        @agents << agent_instance
      end
    end

    delegate :client, :model, to: :config

    private
    def _agents
      Agent.descendants
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
        @agents.map{|agent| agent.class.name.underscore }
      end
    end
  end
end
