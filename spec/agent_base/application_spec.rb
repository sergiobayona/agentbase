# frozen_string_literal: true

require 'spec_helper'
require 'agent_base'

RSpec.describe AgentBase::Application do
  let(:application) { described_class.new }

  describe '#initialize' do
    it 'initializes the application' do
      expect(application.config).to be_a(AgentBase::Configuration)
      expect(application.routes).to be_a(Hash)
      expect(application.routes.values.first).to be_a(AgentBase::Routing::Routes::Route)
    end
  end
end
