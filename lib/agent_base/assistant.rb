module AgentBase
  class Assistant
    attr_reader :config, :tools, :client, :model, :name

    def initialize(config, tools)
      @config = config
      @tools = tools
      @client = initialize_client
      @name = name
    end

    def chat(message)
      client.chat(
        parameters: {
          name:,
          model:,
          messages: [{ role: 'user', content: message }],
          functions: tools.to_schema
        }
      )
    end

    def model
      config.model
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
