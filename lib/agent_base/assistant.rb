# frozen_string_literal: true

module AgentBase
  class Assistant
    def initialize(configuration, parameters)
      @client = configuration.client.new
      @parameters = parameters
    end

    def create
      @client.asistants.create(parameters: parameters)
    end

  end
end
