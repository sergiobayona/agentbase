# frozen_string_literal: true

require 'spec_helper'
require_relative '../agent_base/fixtures/tools/hammer'

RSpec.describe AgentBase::ToolSet do
  it 'returns a hash of all tasks' do
    expect(Hammer.tasks).to be_a(Hash)
  end

  it 'has keys as names of tasks' do
    expect(Hammer.tasks.keys).to eq(%i[smack show find])
  end

  it 'has values as instances of Task' do
    expect(Hammer.tasks.values).to all(be_a(AgentBase::Task))
  end

  it "displays the tool's name" do
    expect(Hammer.name).to eq('Hammer')
  end

  it "displays the tool's weight" do
    expect(Hammer[:show]).to be_a(AgentBase::Task)
  end

  describe '#show' do
    it 'returns the description' do
      description = Hammer[:show].description
      expect(description).to be_empty
    end

    it 'returns the params' do
      params = Hammer[:show].params
      expect(params).to eq(nil)
    end
  end

  describe '#find' do
    it 'returns the description' do
      description = Hammer[:find].description
      expect(description).to eq('Find a hammer by name.')
    end

    it 'returns the params' do
      params = Hammer[:find].params
      expect(params).to eq([{ description: 'The name of the hammer to find.', name: 'name', type: 'String' }])
    end
  end

  describe '#smack' do
    it 'returns the description' do
      description = Hammer[:smack].description
      expect(description).to eq("Smack something with the hammer.\nGrab the hammer and smack something with it.")
    end

    it 'returns the params' do
      params = Hammer[:smack].params
      expect(params).to eq([
                             { description: 'the force to smack with.', name: 'force', type: 'Integer' },
                             { description: 'the thing to smack.', name: 'something', type: 'String' }
                           ])
    end
  end
end
