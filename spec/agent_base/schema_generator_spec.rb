# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/agent_base/schema_generator'

RSpec.describe AgentBase::SchemaGenerator do
  before do
    source = File.expand_path('fixtures/tools', __dir__)
    AgentBase::Tools.source = source
    AgentBase::Tools.load
  end

  describe '#generate' do
    let(:tool) { AgentBase::Tools::Hammer }
    let(:task) { :find }
    let(:schema) { AgentBase::SchemaGenerator.new(tool, task).generate }

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
