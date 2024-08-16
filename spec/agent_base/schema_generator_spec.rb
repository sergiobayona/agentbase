# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/agent_base/schema_generator'
require_relative '../agent_base/fixtures/tools/hammer'

RSpec.describe AgentBase::SchemaGenerator do
  describe '#generate' do
    let(:toolset) { Hammer }
    let(:task) { :find }
    let(:schema) { AgentBase::SchemaGenerator.new(toolset, task).generate }

    it 'returns the schema for the task' do
      expect(schema).to eq(
        type: 'function',
        function: {
          name: 'find_hammer',
          description: 'Find a hammer by name.',
          parameters: {
            type: 'object',
            required: ['name'],
            properties: {
              name: {
                type: 'String',
                description: 'The name of the hammer to find.'
              }
            }
          }
        }
      )
    end
  end
end
