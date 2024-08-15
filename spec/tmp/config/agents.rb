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
