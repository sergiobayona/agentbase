# frozen_string_literal: true

require 'spec_helper'
require 'agent_base/tasks'

RSpec.describe AgentBase::Task do
  let(:tasks) do
    AgentBase::Tasks.draw do
      task 'Display the user information', tool: { UserTools: :show, params: :user_id }
      task 'Create a new user', tool: { UserTools: :create, params: :user_params }
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

    it "initializes the tasks with the 'Display the user information' task" do
      expect(tasks.tasks).to have_key('display_the_user_information')
    end
  end
end
