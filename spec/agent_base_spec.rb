require 'agent_base'

RSpec.describe AgentBase do
  let(:configuration) { double('Configuration', settings: settings) }
  let(:settings) { double('Settings', root_path: nil) }

  before do
    stub_const('AgentBase::Configuration', configuration)
  end

  describe '.configure' do
    it 'yields the configuration settings if block is given' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(settings)
    end

  end

  describe '.root_path=' do
    it 'sets the root path in the configuration settings' do
      path = '/some/path'
      expect(settings).to receive(:root_path=).with(path)
      described_class.root_path = path
    end
  end

  describe '.root_path' do
    it 'retrieves the root path from the configuration settings' do
      path = '/some/path'
      allow(settings).to receive(:root_path).and_return(path)
      expect(described_class.root_path).to eq(path)
    end
  end
end
