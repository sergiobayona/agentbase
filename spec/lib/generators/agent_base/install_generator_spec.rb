require 'spec_helper'

# path to the install generator file
require_relative '../../../../lib/generators/agent_base/install_generator'

RSpec.describe AgentBase::InstallGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __dir__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates config/agents.rb file' do
    assert_file 'config/agents.rb' do |content|
      assert_match(/AgentBase.configure do |config|/, content)
      assert_match(/config.provider = :openai/, content)
      assert_match(/config.openai_api_key = ENV\['OPENAI_API_KEY'\]/, content)
      assert_match(/config.anthropic_api_key = ENV\['ANTHROPIC_API_KEY'\]/, content)
    end
  end

  it 'creates app/agents directory' do
    assert_directory 'app/agents'
  end

  it 'adds app/agents to autoload paths' do
    assert_file 'config/application.rb' do |content|
      assert_match(%r{config.autoload_paths \+= %W\(\#{config.root}/app/agents\)}, content)
    end
  end

  it 'displays post-install message' do
    output = capture(:stdout) { run_generator }
    expect(output).to include('AgentBase has been successfully installed!')
    expect(output).to include('Next steps:')
    expect(output).to include('1. Review and update the configuration in config/agents.rb')
    expect(output).to include('2. Create your agent classes in the app/agents directory')
    expect(output).to include('3. Use AgentBase in your Rails application')
    expect(output).to include('Enjoy building with AgentBase!')
  end
end
