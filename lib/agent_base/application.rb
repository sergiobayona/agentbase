# frozen_string_literal: true

require_relative 'configuration'
require_relative 'routing/routes'
require_relative 'assistant'

module AgentBase
  class Application
    attr_accessor :config, :routes

    def initialize
      Actions.load
      @routes = Routing::Router.app_routes
      @config = ::AgentBase::Configuration.new
    end

    def help(message)
      assistant = AgentBase::Assistant.new(@config)
      assistant.request(message)
    end
  end
end
