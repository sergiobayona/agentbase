# lib/generators/agentbase/install_generator.rb

module AgentBase
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_agents_config_file
      create_file 'config/agents.rb', <<~RUBY
        # AgentBase Configuration
        AgentBase.configure do |config|
          # Set your provider (e.g., :openai or :anthropic)
          config.provider = :openai

          # Set your API keys
          config.openai_api_key = ENV['OPENAI_API_KEY']
          config.anthropic_api_key = ENV['ANTHROPIC_API_KEY']

          # Other configuration options
          config.openai_organization_id = ENV['OPENAI_ORGANIZATION_ID']
          config.anthropic_version = "2023-06-01"
          config.request_timeout = 120
        end
      RUBY
    end

    def create_agents_directory
      empty_directory 'app/agents'
    end

    def add_agents_autoload_path
      application "config.autoload_paths += %W(\#{config.root}/app/agents)"
    end

    def display_post_install_message
      say "\nAgentBase has been successfully installed!", :green
      say "\nNext steps:"
      say '1. Review and update the configuration in config/agents.rb'
      say '2. Create your agent classes in the app/agents directory'
      say '3. Use AgentBase in your Rails application'
      say "\nEnjoy building with AgentBase!", :green
    end
  end
end
