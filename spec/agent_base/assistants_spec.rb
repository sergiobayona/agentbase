# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Assistants do
  before do
    require File.expand_path('../dummy/config/environment', __dir__)
  end

  describe 'initialize' do
    it 'creates a new instance of Assistants' do
      config = double('config')
      assistants = AgentBase::Assistants.new(config)
      expect(assistants).to be_an_instance_of(AgentBase::Assistants)
    end
  end
end
