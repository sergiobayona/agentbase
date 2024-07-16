# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools::Base, load_agentbase: false do
  before do
    source = File.expand_path('../fixtures/tools', __dir__)
    AgentBase::Tools.source = source
    AgentBase::Tools.load_tools
  end

  it 'displays all the tasks for a given tool' do
    expect(AgentBase::Tools::Hammer.tasks).to eq(%i[smack show find])
  end

  it "displays the tool's name" do
    expect(AgentBase::Tools::Hammer.name).to eq('Hammer')
  end

  it "displays the tool's weight" do
    expect(AgentBase::Tools::Hammer[:show]).to be_a(AgentBase::Task)
  end

  describe '#show' do
    it 'returns the description' do
      description = AgentBase::Tools::Hammer[:show].description
      expect(description).to be_empty
    end

    it 'returns the params' do
      params = AgentBase::Tools::Hammer[:show].params
      expect(params).to eq(nil)
    end
  end

  describe '#find' do
    it 'returns the description' do
      description = AgentBase::Tools::Hammer[:find].description
      expect(description).to eq('Find a hammer by name.')
    end

    it 'returns the params' do
      params = AgentBase::Tools::Hammer[:find].params
      expect(params).to eq([{ description: 'the name of the hammer to find.', name: 'name', type: 'String' }])
    end
  end

  describe '#smack' do
    it 'returns the description' do
      description = AgentBase::Tools::Hammer[:smack].description
      expect(description).to eq("Smack something with the hammer.\nGrab the hammer and smack something with it.")
    end

    it 'returns the params' do
      params = AgentBase::Tools::Hammer[:smack].params
      expect(params).to eq([
                             { description: 'the force to smack with.', name: 'force', type: 'Integer' },
                             { description: 'the thing to smack.', name: 'something', type: 'String' }
                           ])
    end
  end
end