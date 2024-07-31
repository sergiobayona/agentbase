# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      @config = Configuration.new
      @assistants = Assistants.new(@config)
    end

    attr_reader :assistants

    delegate :client, :model, to: :config
  end
end
