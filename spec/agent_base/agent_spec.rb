require 'spec_helper'

RSpec.describe AgentBase::Agent do
  let(:config) { double('Config', model: 'test-model', client: double('ClientClass'), api_key: 'test-key', log_errors: true) }
  let(:client_instance) { double('ClientInstance') }
  let(:agent) { described_class.new(config) }

  before do
    allow(config.client).to receive(:new).and_return(client_instance)
  end

  describe '#initialize' do
    it 'initializes with config and client' do
      expect(agent.config).to eq(config)
      expect(agent.client).to eq(client_instance)
    end
  end

  describe '#name' do
    it 'returns the class name' do
      expect(agent.name).to eq(described_class.name)
    end
  end

  describe '#title' do
    it 'returns the class title' do
      allow(described_class).to receive(:title).and_return('Agent Title')
      expect(agent.title).to eq('Agent Title')
    end
  end

  describe '#instructions' do
    it 'returns the class instructions' do
      allow(described_class).to receive(:instructions).and_return('Agent Instructions')
      expect(agent.instructions).to eq('Agent Instructions')
    end
  end

  describe '#model' do
    it 'returns the config model' do
      expect(agent.model).to eq('test-model')
    end
  end

  describe 'class methods' do

    describe '.title' do
      it 'sets and gets the agent title' do
        described_class.title('Test Title')
        expect(described_class.title).to eq('Test Title')
      end
    end

    describe '.instructions' do
      it 'sets and gets the agent instructions' do
        described_class.instructions('Test Instructions')
        expect(described_class.instructions).to eq('Test Instructions')
      end
    end
  end

  describe 'toolset' do
    it 'returns a new ToolSet instance' do
      expect(agent.toolset).to be_a(AgentBase::ToolSet)
    end
  end
end
