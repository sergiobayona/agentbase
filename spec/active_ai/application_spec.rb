# frozen_string_literal: true

require 'spec_helper'
require 'active_ai'

RSpec.describe ActiveAI::Application::ActiveAI do
  let(:application) { described_class.new }

  describe '#initialize' do
    it 'initializes the application' do
      expect(application.config).to be_a(ActiveAI::Configuration)
      expect(application.routes).to be_a(Hash)
      expect(application.routes.values.first).to be_a(ActiveAI::Routing::Routes::Route)
    end
  end
end
