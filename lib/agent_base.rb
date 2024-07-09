# frozen_string_literal: true

require 'agent_base/version'
require 'active_support'
require 'method'

module AgentBase
  class Error < StandardError; end

  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Application
  autoload :Tools
  autoload :Models

  def self.root
    File.expand_path '..', __dir__
  end
end
