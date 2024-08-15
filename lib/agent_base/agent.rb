module AgentBase
  class Agent
    attr_reader :config, :toolset, :client, :model

    def initialize(config)
      @config = config
      @client = initialize_client
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

    def toolset
      self.class.toolset
    end

    def model
      config.model
    end

    class << self
      attr_reader :agent_name, :agent_title, :agent_instructions, :agent_toolset

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

      def toolset(value = nil)
        @agent_toolset = value if value
        @agent_toolset || []
      end
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
