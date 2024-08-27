require 'dry-validation'
require 'dry/validation/contract'
require_relative 'providers/openai'
# require_relative 'providers/anthropic'

module AgentBase
  class Configuration
    DEFAULT_PROVIDER = :openai
    DEFAULT_API_KEY = ENV['OPENAI_API_KEY']
    DEFAULT_AGENTS_PATH = 'app/agents'
    DEFAULT_AGENT_FILE_NAME = 'agent.rb'
    DEFAULT_MODEL = 'gpt-3.5-turbo'
    DEFAULT_CLIENT_RETRIES = 1
    DEFAULT_LOG_ERRORS = true

    attr_reader :provider, :api_key, :model, :client_retries, :client, :log_errors,
                :organization_id, :agents_path, :agent_file_name, :root_path

    def initialize(options = {})
      result = ConfigurationContract.new.call(options)

      raise ConfigurationError, result.errors.to_h unless result.success?

      set_attributes(result.to_h)
    end

    def set_attributes(validated_options)
      @provider = validated_options[:provider] || DEFAULT_PROVIDER
      @api_key = validated_options[:api_key] || DEFAULT_API_KEY
      @model = validated_options[:model] || DEFAULT_MODEL
      @client_retries = validated_options[:client_retries] || DEFAULT_CLIENT_RETRIES
      @client = validated_options[:client] || self.class.default_client
      @log_errors = validated_options.fetch(:log_errors, DEFAULT_LOG_ERRORS)
      @organization_id = validated_options[:organization_id]
      @agents_path = validated_options[:agents_path] || DEFAULT_AGENTS_PATH
      @agent_file_name = validated_options[:agent_file_name] || DEFAULT_AGENT_FILE_NAME
      @root_path = validated_options[:root_path] || self.class.default_root_path

      validate_api_key
    end

    class ConfigurationContract < Dry::Validation::Contract
      params do
        optional(:provider).filled(:symbol)
        optional(:api_key).maybe(:string)
        optional(:model).filled(:string)
        optional(:client_retries).filled(:integer)
        optional(:client).filled
        optional(:log_errors).filled(:bool)
        optional(:organization_id).maybe(:string)
        optional(:agents_path).filled(:string)
        optional(:agent_file_name).filled(:string)
        optional(:root_path).filled(:string)
      end

      rule(:provider) do
        key.failure('must be :openai or :anthropic') unless value.nil? || %i[openai anthropic].include?(value)
      end

      rule(:client_retries) do
        key.failure('must be positive') if value && value <= 0
      end

      rule(:root_path) do
        key.failure('directory does not exist') if value && !Dir.exist?(value)
      end
    end

    def self.default_client
      case DEFAULT_PROVIDER
      when :openai
        AgentBase::Providers::OpenAI.client
      when :anthropic
        AgentBase::Providers::Anthropic.client
      else
        raise ConfigurationError, "Unknown provider: #{DEFAULT_PROVIDER}"
      end
    end

    def self.default_root_path
      defined?(Rails) && Rails.respond_to?(:root) ? Rails.root : Dir.pwd
    end

    private

    def validate_api_key
      return unless @api_key.nil? || @api_key.strip.empty?

      raise ConfigurationError,
            'API key is missing. Please set OPENAI_API_KEY environment variable or provide an api_key in the configuration.'
    end
  end

  class ConfigurationError < StandardError; end
end
