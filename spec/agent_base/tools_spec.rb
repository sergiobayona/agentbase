# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools, load_agentbase: false do
  it 'returns an array of tools' do
    expect(AgentBase::Tools.all).to be_a(Array)
  end

  context 'when tools are loaded' do
    before do
      source = File.expand_path('fixtures/tools', __dir__)
      AgentBase::Tools.source = source
      AgentBase::Tools.load
    end

    it 'checks to see if has a setup' do
      expect(AgentBase::Tools.has_setup?).to eq(true)
    end

    it 'loads the tools' do
      expect(AgentBase::Tools.all).to include(AgentBase::Tools::Hammer)
      expect(AgentBase::Tools.all.first).to be < AgentBase::Tools::Base
    end
  end
end
