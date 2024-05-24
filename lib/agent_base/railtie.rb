# frozen_string_literal: true

require 'rails'
module AgentBase
  class Railtie < Rails::Railtie # :nodoc:
    config.agent_base = ActiveSupport::OrderedOptions.new
    config.agent_base.routes = {}

    config.after_initialize do
      AgentBase::Router.route_source = Rails.root.join('app/agent_base/config/routes.rb')
      AgentBase::Application::AgentBase.new
      config.agent_base.routes = AgentBase::Router.routes
    end
  end
end
