# frozen_string_literal: true

module ActiveAI
  class Assistant
    def initialize(configuration)
      @client = configuration.client.new
    end

    def create
      @client.asistants.create(
        parameters: {
          model: 'gpt-4o',
          name: 'Customer Service Assistant',
          description: 'This assistant is designed to help customers with their questions and concerns.',
          tools: []
        }
      )
    end

    def routing_tool; end

    def request(message)
      request = RequestRouter.new
      request.route(message)
    end
  end
end
