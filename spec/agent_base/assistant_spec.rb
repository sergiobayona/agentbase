# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Assistant do
  subject(:app) { AgentBase::Application.new }

  it 'creates a new assistant' do
    expect(app.assistant).to be_an_instance_of(AgentBase::Assistant)
  end

  it 'has access to th client' do
    expect(app.assistant.client).to be_an_instance_of(OpenAI::Client)
  end

  it 'has access to the tools' do
    expect(app.assistant.tools).to be_an_instance_of(AgentBase::Tools::Base)
  end
end
