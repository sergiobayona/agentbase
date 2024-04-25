require 'spec_helper'

RSpec.describe 'ActiveLlm::Demo' do
  binding.pry
  # assistant = Dummy::Application::LLM.new

  response = assistant.help("I'm user Sergio Bayona with email bayona.sergio@gmail.com")

  expect(response.message).to eq('Hello Sergio Bayona, I have created your account with email')

  expect(response.parameters).to eq({ name: 'Sergio Bayona', email: 'bayona.sergio@gmail.com', id: 1 })
end
