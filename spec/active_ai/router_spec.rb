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
end
