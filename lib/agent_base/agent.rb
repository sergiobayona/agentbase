module AgentBase
  class Agent
    attr_reader :config, :tools, :client, :model, :name

    def initialize(config)
      @config = config
      @tools = gather_tools
      @client = initialize_client
      @name = name
    end

    def chat(message)
      client.chat(
        parameters: {
          name:,
          model:,
          messages: [{ role: 'user', content: message }],
          functions: tools.all
        }
      )
    end

    def path
      binding.pry
    end

    def model
      config.model
    end

    def gather_tools
      self.class.tools.each do |tool|
        binding.pry
      end
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
