# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools, load_agentbase: false do
  context 'when tools are loaded' do
    before do
      source = File.expand_path('fixtures/tools', __dir__)
      AgentBase::Tools.source = source
      AgentBase::Tools.load
    end

    it 'checks to see if has a setup' do
      expect(AgentBase::Tools.has_setup?).to eq(true)
    end

  end
end
