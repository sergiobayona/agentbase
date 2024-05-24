# frozen_string_literal: true

# The AgentBase module is the main namespace for the gem.
module AgentBase
  class Error < StandardError; end
  require 'agent_base/version'
  require 'agent_base/railtie' if defined?(Rails::Railtie)
  require 'agent_base/llm'
  require 'agent_base/assistant'
  require 'agent_base/configuration'
  require 'agent_base/clients/openai'
  require 'agent_base/application'

  def self.root
    File.expand_path '..', __dir__
  end
end
