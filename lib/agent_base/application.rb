# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize(config_file = nil)
      @config = Configuration.new({ config_file: })
      @agents = Agents.new(@config)
    end

    attr_reader :agents

    delegate :client, :model, to: :config
  end
end
