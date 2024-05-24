# frozen_string_literal: true

require 'agent_base/routing/routing'
module AgentBase
  class LLM
    def initialize(client)
      @client = client
      @routes = Routing.app_routes
    end
  end
end
