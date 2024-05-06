require 'spec_helper'

RSpec.describe ActiveAI::Configuration do
  describe '#initialize' do
    it 'sets the default retries to 1 if not provided' do
      configuration = described_class.new
      expect(configuration.client_retries).to eq(1)
    end

    it 'sets the client to the default client if not provided' do
      configuration = ActiveAI::Configuration.new
      expect(configuration.client).to eq(OpenAI::Client)
    end

    it 'sets the api_key to the value from ENV if api_key is not provided' do
      allow(ENV).to receive(:[]).with('OPENAI_API_KEY').and_return('your_api_key')
      configuration = ActiveAI::Configuration.new
      expect(configuration.api_key).to eq('your_api_key')
    end

    it 'yields self if a block is given' do
      yielded_self = nil
      configuration = ActiveAI::Configuration.new do |config|
        yielded_self = config
      end
      expect(yielded_self).to eq(configuration)
    end
  end

  context 'when setting a custom api key' do
    before do
      ActiveAI::Configuration.configure do |config|
        config.api_key = 'abc123'
      end
    end

    it 'returns the configured api_key' do
      expect(ActiveAI::Configuration.settings.api_key).to eq('abc123')
    end

    it 'also works with the shorter method `api_key`' do
      expect(ActiveAI::Configuration.api_key).to eq('abc123')
    end
  end

  describe 'when setting a custom client' do
    let(:custom_client) { double('CustomClient') }

    before do
      ActiveAI::Configuration.configure do |config|
        config.client = custom_client
      end
    end

    it 'returns the configured client' do
      configuration = ActiveAI::Configuration.settings
      expect(configuration.client).to eq(custom_client)
    end
  end

  describe 'when setting a custom model' do
    before do
      ActiveAI::Configuration.configure do |config|
        config.model = 'gpt-3.5-turbo-0613'
      end
    end

    it 'returns the configured model' do
      expect(ActiveAI::Configuration.settings.model).to eq('gpt-3.5-turbo-0613')
    end

    it 'also works with the short `model` method' do
      expect(ActiveAI::Configuration.model).to eq('gpt-3.5-turbo-0613')
    end

    it 'returns the default model if not provided' do
      configuration = ActiveAI::Configuration.new
      expect(configuration.model).to eq('gpt-3.5-turbo')
    end
  end

  describe 'when setting custom client retries' do
    before do
      ActiveAI::Configuration.configure do |config|
        config.client_retries = 5
      end
    end

    it 'returns the configured client retries' do
      expect(ActiveAI::Configuration.settings.client_retries).to eq(5)
    end

    it 'also works with the shorter method `client_retries`' do
      expect(ActiveAI::Configuration.client_retries).to eq(5)
    end

    it 'returns the default client retries if not provided' do
      configuration = ActiveAI::Configuration.new
      expect(configuration.client_retries).to eq(1)
    end
  end

  describe '.reset' do
    before do
      ActiveAI::Configuration.configure do |config|
        config.client = 'custom_client'
        config.model = 'custom_model'
        config.client_retries = 5
      end
    end

    it 'resets the settings' do
      ActiveAI::Configuration.reset
      expect(ActiveAI::Configuration.settings.client).to eq(OpenAI::Client)
      expect(ActiveAI::Configuration.settings.model).to eq('gpt-3.5-turbo')
      expect(ActiveAI::Configuration.settings.client_retries).to eq(1)
    end
  end
end
