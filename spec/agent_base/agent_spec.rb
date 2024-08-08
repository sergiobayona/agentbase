# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Agent do
  subject(:app) { AgentBase::Application.new }

  # it 'has access to th client' do
  #   expect(app.agent.client).to be_an_instance_of(OpenAI::Client)
  # end

  # it 'has access to the tools' do
  #   expect(app.agent.tools).to be_an_instance_of(AgentBase::Tools::Base)
  # end

  # it 'has access to the model' do
  #   expect(app.agent.model).to eq('gpt-3.5-turbo')
  # end

  # it 'can chat with the agent' do
  #   expect(app.agent.chat('Hello')).to be_a(String)
  # end
end
