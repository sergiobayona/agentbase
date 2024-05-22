# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveAI::Routing do
  before do
    ActiveAI::Configuration.reset
  end

  describe '.json_routes' do
    it 'returns the JSON representation of app_routes' do
      expect(described_class.json_routes).to include_json([
                                                            {
                                                              "name": 'user_id',
                                                              "path": '/user/id',
                                                              "parameters": { "id": 'id' },
                                                              "phrasing": ['Show user with id :id', 'My id is :id',
                                                                           'I am user :id']
                                                            },
                                                            {
                                                              "name": 'user_email',
                                                              "path": '/user/email',
                                                              "parameters": { "email": 'email' },
                                                              "phrasing": ['Show user with email :email',
                                                                           'My email is :email', 'I am user :email']
                                                            },
                                                            {
                                                              "name": 'user_email_authenticate',
                                                              "path": '/user/email/authenticate',
                                                              "parameters": { "email": 'email' },
                                                              "phrasing": ['Authenticate user with email :email',
                                                                           'My email is :email']
                                                            }
                                                          ])
    end
  end

  describe '.json_args' do
    it 'returns the list of JSON arguments' do
      expect(described_class.json_args).to eq(%i[name path parameters phrasing])
    end
  end

  describe '.app_routes' do
    it 'returns the values of app_routes' do
      expect(described_class.app_routes).to eq(ActiveAI::Router.app_routes.values)
    end
  end

  describe 'setup?', vcr: 'routing/init' do
    it 'returns false if @@setup is false' do
      expect(described_class).not_to be_setup
    end

    it 'returns true if @@setup is true' do
      described_class.setup
      expect(described_class).to be_setup
    end
  end

  describe 'setup', vcr: 'routing/init' do
    it 'calls LLM.client.chat with the correct parameters' do
      res = described_class.setup
    end
  end
end
