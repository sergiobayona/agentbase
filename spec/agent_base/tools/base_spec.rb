# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools::Base, load_agentbase: false do

  before do
    source = File.expand_path('../fixtures/tools', __dir__)
    AgentBase::Tools.source = source
    AgentBase::Tools.load_tools
  end

  it "displays all the tasks for a given tool" do
    expect(AgentBase::Tools::Hammer.tasks).to eq([:show])
  end

  it "displays the tool's name" do
    expect(AgentBase::Tools::Hammer.name).to eq('Hammer')
  end

  it "displays the tool's weight" do
    expect(AgentBase::Tools::Hammer[:show]).to be_a(AgentBase::Task)
  end

  it "returns the description" do
    expect(AgentBase::Tools::Hammer[:show].description).to eq("display an instance of a hammer")
  end
end
