require 'spec_helper'

RSpec.describe 'ActiveLlm::Demo' do
  let(:assistant) { Dummy::Application::LLM.new }
  let(:response) { assistant.help("I'm user Sergio Bayona with email bayona.sergio@gmail.com") }

  pending 'help response' do
    expect(response).to be_a(ActiveAI::LLM::Response)
  end

  pending 'responds with a message' do
    expected_message = 'Hello Sergio Bayona, I have created your account and sent you an email to complete the registration.'
    expect(response.message).to eq(expected_message)
  end

  pending 'returns the signup parameters' do
    expected_parameters = { name: 'Sergio Bayona', email: 'bayona.sergio@gmail.com', id: 1 }
    expect(response.parameters).to eq(expected_parameters)
  end
end
