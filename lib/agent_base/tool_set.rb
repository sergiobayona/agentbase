require "active_support"

module AgentBase
  class ToolSet
    attr_reader :tools

    def initialize(agent)
      @agent = agent
      @tools = agent.class.toolset.map { |tool| register_tool(tool) }
    end

    private

    def register_tool(tool)
      tool_class = tool.to_s.constantize
      define_singleton_method(tool.to_s.demodulize.downcase) { tool_class }
      tool_class
    rescue NameError => e
      raise ToolLoadError, "Failed to register tool #{tool}: #{e.message}"
    end
  end
end
