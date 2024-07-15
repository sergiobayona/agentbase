# frozen_string_literal: true

require 'spec_helper'
require 'agent_base/tasks'

RSpec.describe AgentBase::Task do
  let(:tasks) do
    AgentBase::Tasks.draw do
      task 'Display the user information', tool: { UserTools: :show, params: { name: :user_id, description: 'the user identifier' } }
      task 'Create a new user', tool: { UserTools: :create, params: [
        {
          name: :email,
          description: "the user's email address"
        }
      ] }
      task 'Authenticate a user', tool: { UserTools: :authenticate, params: %i[email password] }
    end
  end

  describe '#initialize' do
    it 'initializes the tasks' do
      expect(tasks).to be_a(AgentBase::Tasks)
    end

    it 'initializes the tasks with the correct number of tasks' do
      expect(tasks.tasks.size).to eq(3)
    end
  end

  describe '#all' do
    it 'returns a hash of tasks' do
      expect(tasks.all).to be_a(Hash)
    end

    it 'has keys as strings' do
      expect(tasks.all.keys).to eq(%w[display_the_user_information create_a_new_user authenticate_a_user])
    end

    it 'has tasks as values' do
      expect(tasks.all.values).to all(be_a(AgentBase::Task))
    end
  end

  describe '#[]' do
    it 'returns a task' do
      expect(tasks['display_the_user_information']).to be_a(AgentBase::Task)
    end
  end
end
