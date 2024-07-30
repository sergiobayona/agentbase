# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Configuration do
  let(:custom_client) { double('CustomClient') }

  describe '#initialize' do
    it 'sets the default values if not provided' do
      allow(ENV).to receive(:[]).with('OPENAI_API_KEY').and_return('your_api_key')
      allow(ENV).to receive(:[]).with('OPENAI_ORGANIZATION_ID').and_return(nil)
      configuration = described_class.new
      expect(configuration.client_retries).to eq(1)
      expect(configuration.client).to eq(OpenAI::Client)
      expect(configuration.api_key).to eq('your_api_key')
      expect(configuration.model).to eq('gpt-3.5-turbo')
      expect(configuration.log_errors).to eq(true)
    end

    it 'yields self if a block is given' do
      yielded_self = nil
      configuration = described_class.new { |config| yielded_self = config }
      expect(yielded_self).to eq(configuration)
    end
  end

  describe '#configure' do
    before do
      described_class.configure do |config|
        config.api_key = 'abc123'
        config.client = custom_client
        config.model = 'gpt-3.5-turbo-0613'
        config.client_retries = 5
        config.log_errors = false
      end
    end

    it 'sets the custom values' do
      expect(described_class.settings.api_key).to eq('abc123')
      expect(described_class.settings.client).to eq(custom_client)
      expect(described_class.settings.model).to eq('gpt-3.5-turbo-0613')
      expect(described_class.settings.client_retries).to eq(5)
      expect(described_class.settings.log_errors).to eq(false)
    end
  end

  describe '.reset' do
    before do
      described_class.configure do |config|
        config.client = 'custom_client'
        config.model = 'custom_model'
        config.client_retries = 5
      end
    end

    it 'resets the settings' do
      described_class.reset
      expect(described_class.settings.client).to eq(OpenAI::Client)
      expect(described_class.settings.model).to eq('gpt-3.5-turbo')
      expect(described_class.settings.client_retries).to eq(1)
      expect(described_class.settings.log_errors).to eq(true)
    end
  end
end
