require 'active_support/core_ext/module'

module AgentBase
  class Agent
    class << self
      attr_writer :name, :title, :instructions, :toolset

      def name(value = nil)
        @name = value if value
        @name || to_s.demodulize.underscore
      end

      def title(value = nil)
        @title = value if value
        @title || name.humanize
      end

      def instructions(value = nil)
        @instructions = value if value
        @instructions || 'I am an AI assistant. How can I help you?'
      end

      def toolset(value = nil)
        @toolset = value if value
        @toolset || []
      end

    end

    attr_reader :config, :client, :toolset

    def initialize(config)
      @config = config
      @client = initialize_client
      @toolset = ToolSet.new(self)
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

    def model
      config.model
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    rescue StandardError => e
      raise AgentInitializationError, "Failed to initialize client: #{e.message}"
    end
  end
end
