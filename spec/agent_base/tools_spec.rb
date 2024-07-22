# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools, load_agentbase: false do
  it 'returns all the loaded tools' do
    source = File.expand_path('fixtures/tools', __dir__)
    AgentBase::Tools.source = source

    AgentBase::Tools.load_tools
    tools = AgentBase::Tools.all

    expect(tools).to include(AgentBase::Tools::Hammer)
    expect(tools.first).to be < AgentBase::Tools::Base
  end

end
