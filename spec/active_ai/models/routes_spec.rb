# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveAI::Models::Routes do
  describe 'function' do
    it 'returns the name of the route' do
      expect(described_class.name).to eq('system_routes')
    end
  end

  describe 'schema' do
    it 'defines the schema for the model' do
      expect(described_class.json_schema).to include_json({
                                                            "type": 'object',
                                                            "properties": {
                                                              "name": {
                                                                "type": 'string',
                                                                "description": 'The name of the route'
                                                              },
                                                              "path": {
                                                                "type": 'string',
                                                                "description": 'The path to the route'
                                                              },
                                                              "parameters": {
                                                                "type": 'object',
                                                                "title": 'system_params',
                                                                "properties": {
                                                                  "key": {
                                                                    "type": 'string',
                                                                    "description": 'The parameter key'
                                                                  },
                                                                  "value": {
                                                                    "type": 'string',
                                                                    "description": 'The parameter value'
                                                                  }
                                                                }
                                                              },
                                                              "title": {
                                                                "type": 'string',
                                                                "description": 'A short description of the conversation'
                                                              }
                                                            },
                                                            "required": %w[
                                                              name
                                                              path
                                                              title
                                                            ]
                                                          })
    end
  end
end
