module ActiveAI
  class Assistant
    def initialize(configuration)
      @client = configuration.client.new
    end

    def request(message)
      request = RequestRouter.new
      request.route(message)
    end
  end
end
