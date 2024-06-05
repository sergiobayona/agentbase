# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Tools do
  describe 'load' do
    it 'loads all the tools' do
      expect(described_class.constants).not_to include(:User)

      described_class.source = Rails.root.join('app', 'agent_base', 'tools')
      described_class.load
      expect(described_class.constants).to include(:User)
    end
  end

  describe 'Base' do
    let!(:user) { User.create!(name: 'John Doe', email: 'joe@test.com', password: 'password') }

    it 'is a class' do
      described_class.load
      user_tools = AgentBase::Tools::UserTools.new
      user_tools.show(user.id)
    end
  end
end
