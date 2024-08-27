module AgentBase
  class Agent
    attr_reader :config, :client, :module_name

    def initialize(config, module_name)
      @config = config
      @client = initialize_client
      @module_name = module_name
      load_toolset
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

    def toolset
      @toolset ||= ToolSet.new(self.class.toolset, self)
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
      self.class.toolset.each do |tool|
        require_tool(tool)
      rescue LoadError => e
        puts "Failed to load tool #{tool}: #{e.message}"
      end
    end

    def require_tool(tool)
      tool_file = "tools/#{tool.to_s.underscore}"
      require tool_file
    rescue LoadError
      # If the generic path doesn't work, try a more specific path
      require Rails.root.join('app', 'agents', "#{@module_name.downcase}", "#{tool.to_s.underscore}.rb")
    end

    private

    def initialize_client
      config.client.new(access_token: config.api_key, log_errors: config.log_errors)
    end
  end
end
