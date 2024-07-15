require 'rails'
require 'agent_base'

module AgentBase
  class Engine < ::Rails::Engine
    isolate_namespace AgentBase

    config.after_initialize do
      AgentBase::Tools.source = Rails.root.join('app/agent_base/tools')
      AgentBase::Models.source = Rails.root.join('app/agent_base/models')

      AgentBase::Application.new # start the application
    end
  end
end
