module AgentBase
  class Assistant
    attr_reader :config, :tools, :client

    def initialize(config, tools)
      @config = config
      @tools = tools
      @client = initialize_client
    end

    def chat(message)
      client.chat(
        parameters: {
          model: config.model,
          messages: [{ role: 'user', content: message }],
          functions: tools.to_schema
        }
      )
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
