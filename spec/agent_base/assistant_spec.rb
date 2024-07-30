# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Assistant do
  subject(:app) { AgentBase::Application.new }

  it 'creates a new assistant' do
    expect(app.assistants).to be_an_instance_of(AgentBase::Assistants)
  end

  it 'has access to th client' do
    expect(app.assistant.client).to be_an_instance_of(OpenAI::Client)
  end

  it 'has access to the tools' do
    expect(app.assistant.tools).to be_an_instance_of(AgentBase::Tools::Base)
  end

  it 'has access to the model' do
    expect(app.assistant.model).to eq('gpt-3.5-turbo')
  end

  it 'can chat with the assistant' do
    expect(app.assistant.chat('Hello')).to be_a(String)
  end
end
