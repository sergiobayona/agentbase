# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      @tools = Tools::Base.new
      # @models = Models.load_models

      @config = Configuration.new
    end

    attr_reader :tools

    def help(message)
      assistant = AgentBase::Assistant.new(@config)
      assistant.request(message)
    end
  end
end
