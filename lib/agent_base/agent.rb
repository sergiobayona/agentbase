require "active_support/core_ext/module"

module AgentBase
  class Agent
    class << self
      def inherited(subclass)
        subclass.instance_variable_set(:@config, config.dup)
      end

      def config
        @config ||= {
          name: nil,
          title: nil,
          instructions: "I am an AI assistant. How can I help you?",
          toolset: []
        }
      end

      def name(value = nil)
        config[:name] = value if value
        config[:name] ||= to_s.demodulize.underscore
      end

      def title(value = nil)
        config[:title] = value if value
        config[:title] ||= name.humanize
      end

      def instructions(value = nil)
        config[:instructions] = value if value
        config[:instructions]
      end

      def toolset(*tools)
        config[:toolset] = tools if tools.any?
        config[:toolset]
      end

      def model(value = nil)
        config[:model] = value if value
        config[:model]
      end
    end

    attr_reader :name, :title, :instructions, :toolset, :model, :app_config

    def initialize(app_config, options = {})
      @app_config = app_config
      @name = options[:name] || self.class.name
      @title = options[:title] || self.class.title
      @instructions = options[:instructions] || self.class.instructions
      @toolset = options[:toolset] || ToolSet.new(self)
      @model = options[:model] || self.class.model || app_config.model
    end

    private

    def initialize_client
      @app_config.client.new(
        access_token: config.api_key,
        log_errors: config.log_errors
      )
    rescue StandardError => e
      raise AgentInitializationError,
            "Failed to initialize client: #{e.message}"
    end
  end
end
