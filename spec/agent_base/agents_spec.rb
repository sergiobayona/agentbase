require 'spec_helper'

RSpec.describe AgentBase::Agents do
  subject { described_class.new(config) }

  let(:config) { double('Config', agents_path: 'spec/fixtures/agents', agent_file_name: '*.rb') }
  let(:service_agent) do
    Class.new(AgentBase::Agent) do
      def self.name
        'TestAgent'
      end

      def initialize(config)
      end
    end
  end

  before do
    stub_const('Agent', Class.new)
    allow(Agent).to receive(:descendants).and_return([service_agent])
    allow_any_instance_of(AgentBase::Agents).to receive(:require)
  end

  describe '#initialize' do
    it 'initializes with config, loads and registers agents' do
      expect(subject.config).to eq(config)
      expect(subject.registered_agents.size).to eq(1)
      expect(subject.registered_agent_names).to include('test_agent')
      expect(subject).to respond_to(:test_agent)
    end
  end

  describe 'aliases' do
    it 'aliases all to agents' do
      expect(subject.all).to eq(subject.agents)
    end

    it 'aliases names to registered_agent_names' do
      expect(subject.names).to eq(subject.registered_agent_names)
    end
  end
end
