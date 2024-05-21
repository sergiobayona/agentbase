# frozen_string_literal: true

require 'rails'
module ActiveAI
  class Railtie < Rails::Railtie # :nodoc:
    config.active_ai = ActiveSupport::OrderedOptions.new
    config.active_ai.routes = {}

    config.after_initialize do
      ActiveAI::Router.route_source = Rails.root.join('app/active_ai/config/routes.rb')
      ActiveAI::Application::ActiveAI.new
      config.active_ai.routes = ActiveAI::Router.routes
    end
  end
end
