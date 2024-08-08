require 'spec_helper'

RSpec.describe AgentBase::Application do
  subject { described_class.new }

  describe '#initialize' do
    it 'initializes with a Configuration instance' do
      expect(subject.config).to be_an_instance_of(AgentBase::Configuration)
    end

    it 'initializes with an Agents instance' do
      expect(subject.agents).to be_an_instance_of(AgentBase::Agents)
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

  describe 'delegation' do
    let(:config) { double('Config', agents_path: 'lib/', agent_file_name: 'agent.rb') }

    before do
      allow(AgentBase::Configuration).to receive(:new).and_return(config)
      allow(config).to receive(:client)
      allow(config).to receive(:model)
    end

    it 'delegates client to config' do
      expect(config).to receive(:client)
      subject.client
    end

    it 'delegates model to config' do
      expect(config).to receive(:model)
      subject.model
    end
  end
end
