require 'spec_helper'

RSpec.describe AgentBase::Application do
  subject { described_class.new }

  let(:service_agent) do
    Class.new(AgentBase::Agent) do
      def self.name
        'TestAgent'
      end
    end
  end

  before do
    allow(AgentBase::Agent).to receive(:descendants).and_return([service_agent])
    allow_any_instance_of(AgentBase::Application).to receive(:require)
  end

  describe '#initialize' do
    it 'initializes with a Configuration instance' do
      expect(subject.config).to be_an_instance_of(AgentBase::Configuration)
    end
  end

  describe 'attributes' do
    it 'has a config attribute' do
      expect(subject).to respond_to(:config)
    end

    it 'has an agents attribute' do
      expect(subject).to respond_to(:agents)
    end
  end

  describe 'agents' do
    it 'returns agents' do
      expect(subject.agents).to be_an_instance_of(AgentBase::Application::Agents)
    end

    it "returns their names" do
      expect(subject.agents.names).to include('test_agent')
    end

    it "returns their size" do
      expect(subject.agents.size).to eq(1)
    end

    it "returns all the agents" do
      expect(subject.agents.all).to include(service_agent)
    end
  end

  describe "generates methods for each agent" do
    it "returns the agent instance" do
      expect(subject.agents.test_agent).to be_an_instance_of(service_agent)
    end
  end
end
