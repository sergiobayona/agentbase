# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Agents do
  before do
    require File.expand_path('../dummy/config/environment', __dir__)
  end

  describe 'initialize' do
    it 'creates a new instance of Agents' do
      config = double('config', agents_path: 'some/path', agent_file_name: 'agent.rb')
      agents = AgentBase::Agents.new(config)
      expect(agents).to be_an_instance_of(AgentBase::Agents)
    end
  end
end
