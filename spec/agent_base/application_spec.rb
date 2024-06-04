# frozen_string_literal: true

require 'spec_helper'
require 'agent_base'

RSpec.describe AgentBase::Application do
  let(:application) { described_class.new }

  describe '#initialize' do
    it 'initializes the application' do
      expect(application.config).to be_a(AgentBase::Configuration)
    end
  end
end
