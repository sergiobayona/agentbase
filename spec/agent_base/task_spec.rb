# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Task, load_agentbase: false do
  subject(:task) { AgentBase::Tools::Hammer[:find] }

  before do
    source = File.expand_path('fixtures/tools', __dir__)
    AgentBase::Tools.source = source
    AgentBase::Tools.load
  end

  it "returns the task's name" do
    expect(task.name).to eq(:find)
  end

  it "returns the task's tool" do
    expect(task.tool).to eq(AgentBase::Tools::Hammer)
  end

  it "returns the task's description" do
    expect(task.description).to eq('Find a hammer by name.')
  end

  it "returns the task's params" do
    expect(task.params).to eq([{ description: 'The name of the hammer to find.', name: 'name', type: 'String' }])
  end

  it "returns the task's schema" do
    schema = task.schema
    expect(schema).to be_a(Hash)
    expect(schema).to eq({
                           type: 'function',
                           function: {
                             name: 'find_hammer',
                             description: 'Find a hammer by name.',
                             parameters: {
                               type: 'object',
                               properties: {
                                 name: {
                                   type: 'String',
                                   description: 'The name of the hammer to find.'
                                 }
                               },
                               required: ['name']
                             }
                           }
                         })
  end
end
