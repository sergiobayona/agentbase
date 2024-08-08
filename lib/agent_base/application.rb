# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      @config = Configuration.new
      @agents = Agents.new(@config)
    end

    attr_reader :agents

    delegate :client, :model, to: :config
  end
end
