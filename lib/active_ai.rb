# frozen_string_literal: true

# The ActiveAI module is the main namespace for the gem.
module ActiveAI
  class Error < StandardError; end
  require 'active_ai/version'
  require 'active_ai/railtie' if defined?(Rails::Railtie)
  require 'active_ai/llm'
  require 'active_ai/assistant'
  require 'active_ai/configuration'
  require 'active_ai/clients/openai'
  require 'active_ai/application'

  def self.root
    File.expand_path '..', __dir__
  end
end
