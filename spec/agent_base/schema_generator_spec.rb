# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/agent_base/schema_generator'

RSpec.describe AgentBase::SchemaGenerator do
  describe '#generate' do
    let(:tool) { AgentBase::Tools::Hammer }
    let(:task) { :smack }
    let(:schema) { AgentBase::SchemaGenerator.new(tool, name).generate }

    it 'returns the schema for the task' do
      expect(schema).to eq(
        type: 'object',
        description: 'Smack something with a hammer',
        properties: {
          force: {
            type: 'Integer',
            description: 'The force with which to smack'
          },
          something: {
            type: 'String',
            description: 'Something to smack'
          }
        }
      )
    end
  end
end
