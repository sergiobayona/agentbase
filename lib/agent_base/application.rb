# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      @config = Configuration.new
      @tools = Tools::Base.new
      @assistant = Assistant.new(@config, @tools)
    end

    attr_reader :tools, :assistant

    delegate :client, :model, to: :config

  end
end
