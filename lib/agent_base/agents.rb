require_relative 'agent'
module AgentBase
  class Agents
    attr_reader :config, :registered_agent_names, :registered_agents

    def initialize(config)
      @registered_agents = []
      @registered_agent_names = []
      @config = config
      load_agents
      register_agents
    end

    def load_agents
      Dir.glob(Rails.root.join(config.agents_path, '**', config.agent_file_name)).each do |file|
        require file
      end
    end

    def agents
      Agent.descendants
    end

    def register_agents
      agents.each do |agent|
        agent_instance = agent.new(config)
        registered_agents << agent_instance
        registered_agent_names << agent.name.underscore
        define_singleton_method(agent.name.underscore) do
          agent_instance
        end
      end
    end

    alias all agents
    alias names registered_agent_names
  end
end
