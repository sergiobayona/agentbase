# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      Tools.load
      Models.load
      # Tasks.load

      @config = ::AgentBase::Configuration.new
    end

    def help(message)
      assistant = AgentBase::Assistant.new(@config)
      assistant.request(message)
    end
  end
end
