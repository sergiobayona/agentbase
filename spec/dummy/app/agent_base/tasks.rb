# frozen_string_literal: true

module Tasks
  require 'agent_base/tasks'

  AgentBase::Tasks.draw do
    task 'Display the user information', tool: { UserTools: :show, params: :user_id }
    task 'Create a new user', tool: { UserTools: :create, params: :user_params }
    task 'Authenticate a user', tool: { UserTools: :authenticate, params: %i[email password] }
  end
end
