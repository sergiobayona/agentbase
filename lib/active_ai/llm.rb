# frozen_string_literal: true

require 'active_ai/routing/routing'
module ActiveAI
  class LLM
    def initialize(client)
      @client = client
      @routes = Routing.app_routes
    end
  end
end
