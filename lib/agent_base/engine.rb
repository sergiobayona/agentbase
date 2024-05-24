require 'rails'
require 'agent_base'

module AgentBase
  class Engine < ::Rails::Engine
    isolate_namespace AgentBase

    config.after_initialize do
      AgentBase::Tools.source = Rails.root.join('app/agent_base/tools')
    end
  end
end
