# frozen_string_literal: true

require "rake"
require "agent_base"
require "rspec"
require "vcr"
require "rspec/mocks"
require "pry"
require "rspec/json_expectations"
require "rails/generators"
require "rails/generators/test_case"
require "generator_spec"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include GeneratorSpec::TestCase
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<OPENAI_KEY_PLACEHOLDER>") do
    ENV.fetch("OPENAI_API_KEY", "XXXXX")
  end
  config.filter_sensitive_data("<ANTHROPIC_KEY_PLACEHOLDER>") do
    ENV.fetch("ANTHROPIC_API_KEY", "XXXXX")
  end
end
