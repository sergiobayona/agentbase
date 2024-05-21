# frozen_string_literal: true

require_relative 'lib/active_ai/version'

Gem::Specification.new do |spec|
  spec.name = 'active_ai'
  spec.version = ActiveAI::VERSION
  spec.authors = ['Sergio Bayona']
  spec.email = ['bayona.sergio@gmail.com']

  spec.summary = 'ActiveAI: A framework for multimodal AI applications.'
  spec.description = 'A Rails-mountable framework for building application using multimodal Artificial Intelligence.'
  spec.homepage = 'https://github.com/sergiobayona/active_ai'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/sergiobayona/active_ai'
  spec.metadata['changelog_uri'] = 'https://github.com/sergiobayona/active_ai/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ .git .github Gemfile])
    end
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'instructor-rb'
  spec.add_dependency 'jbuilder', '~> 2.11'
  spec.add_dependency 'json-schema', '~> 4'
  spec.add_dependency 'rails', '~> 7.0'
  spec.add_dependency 'ruby-openai', '~> 7'
  spec.add_dependency 'sorbet-runtime', '~> 0.5'
  spec.add_development_dependency 'pry-byebug', '>= 3.10'
  spec.add_development_dependency 'rake', '~> 13.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-json_expectations', '~> 2.0'
  spec.add_development_dependency 'rspec-mocks', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.29'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.13'
end
