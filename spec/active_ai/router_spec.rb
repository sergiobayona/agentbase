require 'spec_helper'

RSpec.describe ActiveAI::Routing::Router do
  it 'returns an instance of ActiveAI::Routing::Router' do
    expect(ActiveAI::Router).to eq(ActiveAI::Routing::Router)
  end

  it 'returns a pathname' do
    expect(ActiveAI::Router.route_source).to be_a(Pathname)
    expect(ActiveAI::Router.route_source.to_s).to include('config/routes.rb')
  end

  it 'returns an instance of ActiveAI::Routing::Routes' do
    expect(ActiveAI::Router.routes).to be_a(ActiveAI::Routing::Routes)
  end

  it 'loads the routes' do
    expect(ActiveAI::Router.load_routes).to eq(true)
  end

  it "returns the app's routes" do
    expect(ActiveAI::Router.app_routes).to be_a(Hash)
  end

  describe 'flexing the router tool' do
    it 'returns the correct route', vcr: 'router/flexing' do
      expect(ActiveAI::Router.route_for_message('Show user with id 123')).to eq('/user/id')
    end
  end
end
