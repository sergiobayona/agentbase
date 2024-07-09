require 'json'
require 'jbuilder'

module AgentBase
  module Renderable
    def render(argument)
      Jbuilder.new do |json|
        # user_binding = binding
        # user_binding.local_variable_set(:user, user)
        json.instance_eval(template, 'show.json.jbuilder')
      end.target!
    end

    def template
      File.read(Rails.root.join('app', 'agent_base', 'schemas', 'show.json.jbuilder').to_s)
    end
  end
end
