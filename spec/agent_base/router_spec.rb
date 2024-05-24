# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AgentBase::Routing::Router do
  it 'returns an instance of AgentBase::Routing::Router' do
    expect(AgentBase::Router).to eq(described_class)
  end

  it 'returns a pathname' do
    expect(AgentBase::Router.route_source).to be_a(Pathname)
    expect(AgentBase::Router.route_source.to_s).to include('config/routes.rb')
  end

  it 'returns an instance of AgentBase::Routing::Routes' do
    expect(AgentBase::Router.routes).to be_a(AgentBase::Routing::Routes)
  end

  it 'loads the routes' do
    expect(AgentBase::Router.load_routes).to eq(true)
  end

  it "returns the app's routes" do
    expect(AgentBase::Router.app_routes).to be_a(Hash)
  end

  describe 'flexing the router tool' do
    # it 'returns the correct route', vcr: 'router/flexing' do
    #   expect(AgentBase::Router.route_for_message('Show user with id 123')).to eq('/user/id')
    # end
  end
end
