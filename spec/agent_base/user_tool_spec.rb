# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::UserTool do
  describe 'load' do
    it 'loads all the tools', load_agentbase: false do
      described_class.source = Rails.root.join('app', 'agent_base', 'tools')
      described_class.load
      expect(described_class.constants).to include(:User)
    end
  end

  describe 'Base' do
    let!(:user) { User.create!(name: 'John Doe', email: 'joe@test.com', password: 'password') }

    before do
      require 'agent_base/engine'
    end

    it 'returns json schema' do
      described_class.load
      user_tools = AgentBase::Tools::User.new
      binding.pry
      expect(user_tools.show(user.id)).to include_json({
                                                         "type": 'function',
                                                         "function": {
                                                           "name": 'User.show',
                                                           "description": 'retrieve a user record',
                                                           "parameters": {
                                                             "type": 'object',
                                                             "properties": {
                                                               "user_id": {
                                                                 "type": 'string',
                                                                 "description": 'The user identifier'
                                                               }
                                                             },
                                                             "required": ['user_id']
                                                           }
                                                         }
                                                       })
    end
  end
end
