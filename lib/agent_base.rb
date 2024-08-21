# frozen_string_literal: true

require 'agent_base/version'
require 'active_support'
require 'method'

module AgentBase
  class Error < StandardError; end

  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Application
  autoload :ToolSet
  autoload :Models
  autoload :SchemaGenerator
  autoload :Task
  autoload :Agents
  autoload :Agent

  class << self
    def configure
      yield(Configuration.settings) if block_given?
    end

    def root_path=(path)
      Configuration.settings.root_path = path
    end

    def root_path
      Configuration.settings.root_path
    end
  end
end
