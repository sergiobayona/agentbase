module AgentBase
  class Agent
    attr_reader :config, :tools, :client, :model

    def initialize(config)
      @config = config
      @client = initialize_client
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

    def name
      self.class.name
    end

    def title
      self.class.title
    end

    def instructions
      self.class.instructions
    end

    def tools
      self.class.tools
    end

    def model
      config.model
    end

    class << self
      attr_reader :agent_name, :agent_title, :agent_instructions, :agent_tools

      def name(value = nil)
        @agent_name = value if value
        @agent_name || to_s.demodulize.underscore
      end

      def title(value = nil)
        @agent_title = value if value
        @agent_title || name.humanize
      end

      def instructions(value = nil)
        @agent_instructions = value if value
        @agent_instructions || 'I am an AI assistant. How can I help you?'
      end

      def tools(value = nil)
        @agent_tools = value if value
        @agent_tools || []
      end
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
