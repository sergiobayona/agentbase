require_relative 'agent'
module AgentBase
  class Agents
    attr_reader :config

    def initialize(config)
      @config = config
      load_agents
    end

    def load_agents
      Dir.glob(Rails.root.join(config.agents_path, '**', config.agent_file_name)).each do |file|
        require file
      end
    end

    def agents
      agent.descendants
    end

    alias all agents

    def start_agents
      agents.each do |agent|
        agent.new(config)
      end
    end

    # use method_missing to define a method for each agent
    # that returns the instance of the agent.
    # This allows us to call the agent by name.
    def method_missing(method_name, *args, &block)
      agent = agent.descendants.find { |a| a.name == method_name.to_s }
      return agent.new(config) if agent

      super
    end
  end
end
