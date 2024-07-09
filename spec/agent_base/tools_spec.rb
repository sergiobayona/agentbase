# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools, load_agentbase: false do
  before { AgentBase::Tools.reset }

  describe '.load' do
    it 'loads all files in the source directory' do
      source = File.expand_path('fixtures/tools', __dir__)
      AgentBase::Tools.source = source
      expect { AgentBase::Tools.load_tools }.to change { AgentBase::Tools.constants.size }.by(1)
    end
  end

  it "returns all the loaded tools" do
    source = File.expand_path('fixtures/tools', __dir__)
    AgentBase::Tools.source = source

    AgentBase::Tools.load_tools
    tools = AgentBase::Tools.all

    expect(tools).to eq([AgentBase::Tools::Hammer])
    expect(tools.first).to be < AgentBase::Tools::Base
  end

  it "resets the loaded tools" do
    source = File.expand_path('fixtures/tools', __dir__)
    AgentBase::Tools.source = source

    AgentBase::Tools.load_tools
    expect { AgentBase::Tools.reset }.to change { AgentBase::Tools.constants.size }.by(-1)
  end
end
