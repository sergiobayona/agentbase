# frozen_string_literal: true

require 'rake'
require 'agent_base'
require 'rspec'
require 'vcr'
require 'rspec/mocks'
require 'pry-byebug'
require 'rspec/json_expectations'
require 'database_cleaner/active_record'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('dummy/config/environment', __dir__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../spec/dummy/db/migrate', __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../db/migrate', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
DatabaseCleaner.clean

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<OPENAI_KEY_PLACEHOLDER>') { ENV.fetch('OPENAI_API_KEY', 'XXXXX') }
  config.filter_sensitive_data('<ANTHROPIC_KEY_PLACEHOLDER>') { ENV.fetch('ANTHROPIC_API_KEY', 'XXXXX') }
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
