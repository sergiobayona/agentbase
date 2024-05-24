require 'rails'
require 'agent_base'
require 'agent_base/actions'

module AgentBase
  class Engine < ::Rails::Engine
    isolate_namespace AgentBase

    config.after_initialize do
      AgentBase::Actions.source = Rails.root.join('app/agent_base/actions')
    end
  end
end
