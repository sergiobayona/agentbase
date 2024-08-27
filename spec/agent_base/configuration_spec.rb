# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Configuration do
  let(:custom_client) { double('CustomClient') }

  describe '#initialize' do

    it 'sets the default values if not provided' do
      configuration = described_class.new
      expect(configuration.provider).to eq(:openai)
      expect(configuration.client_retries).to eq(1)
      expect(configuration.client).to eq(OpenAI::Client)
      expect(configuration.api_key).to be_a(String)
      expect(configuration.model).to eq('gpt-3.5-turbo')
      expect(configuration.log_errors).to eq(true)
      expect(configuration.organization_id).to be_nil
      expect(configuration.agents_path).to eq('app/agents')
      expect(configuration.agent_file_name).to eq('agent.rb')
      expect(configuration.root_path).to eq(Dir.pwd)
    end

    it 'sets the custom values if provided' do
      allow(Dir).to receive(:exist?).and_return(true)

      configuration = described_class.new(
        provider: :anthropic,
        client: custom_client,
        api_key: 'abc123',
        model: 'gpt-4o-turbo',
        client_retries: 5,
        log_errors: false,
        organization_id: 'org_123',
        agents_path: 'app/custom/path',
        agent_file_name: 'custom_agent.rb',
        root_path: '/custom/path'
      )
      expect(configuration.provider).to eq(:anthropic)
      expect(configuration.client).to eq(custom_client)
      expect(configuration.api_key).to eq('abc123')
      expect(configuration.model).to eq('gpt-4o-turbo')
      expect(configuration.client_retries).to eq(5)
      expect(configuration.log_errors).to eq(false)
      expect(configuration.organization_id).to eq('org_123')
      expect(configuration.agents_path).to eq('app/custom/path')
      expect(configuration.agent_file_name).to eq('custom_agent.rb')
      expect(configuration.root_path).to eq('/custom/path')
    end
  end

end
