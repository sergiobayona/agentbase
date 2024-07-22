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

    def routing_tool; end

    def request(message)
      request = RequestRouter.new
      request.route(message)
    end
  end
end
