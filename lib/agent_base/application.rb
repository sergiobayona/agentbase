# frozen_string_literal: true

module AgentBase
  class Application
    attr_accessor :config

    def initialize
      @config = Configuration.new
      @tools = Tools::Base.new
      @assistants = Assistants.new
    end

    attr_reader :tools, :assistants

    delegate :client, :model, to: :config
  end
end
