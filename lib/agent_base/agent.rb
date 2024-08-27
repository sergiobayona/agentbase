module AgentBase
  class Agent
    attr_reader :config, :client, :module_name, :toolset

    def initialize(config, module_name)
      @config = config
      @client = initialize_client
      @module_name = module_name
      load_toolset
      rescue StandardError => e
        raise AgentInitializationError, "Failed to initialize agent: #{e.message}"
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

    def load_toolset
      @toolset = ToolSet.new(self.class.toolset, self)
      self.class.toolset.each do |tool|
        require_tool(tool)
      rescue StandardError => e
        raise ToolLoadError, "Failed to load toolset: #{e.message}"
      end
    end

    private

    def require_tool(tool)
      tool_file = "tools/#{tool.to_s.underscore}"
      require tool_file
    rescue LoadError
      begin
        require Rails.root.join('app', 'agents', "#{@module_name.downcase}", "#{tool.to_s.underscore}.rb")
      rescue LoadError => e
        raise ToolLoadError, "Failed to load tool #{tool}: #{e.message}"
      end
    end

    def initialize_client
      @client = config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    rescue StandardError => e
      raise AgentInitializationError, "Failed to initialize client: #{e.message}"
    end
  end
end
