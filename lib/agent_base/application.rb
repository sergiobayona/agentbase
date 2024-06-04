# frozen_string_literal: true

require_relative 'configuration'
require_relative 'routing/routes'
require_relative 'assistant'
require_relative 'tools'

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      Tools.load
      Models.load
      @config = ::AgentBase::Configuration.new
    end

    def help(message)
      assistant = AgentBase::Assistant.new(@config)
      assistant.request(message)
    end
  end
end
