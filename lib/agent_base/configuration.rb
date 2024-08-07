# frozen_string_literal: true

require 'agent_base/clients/openai'

module AgentBase
  class Configuration
    attr_reader :api_key, :model, :client_retries, :client, :log_errors, :organization_id, :agents_path,
                :agent_file_name

    def initialize(options = {})
      @options = options.dup
      yield(self) if block_given?
      @client_retries = @options.fetch(:client_retries, 1)
      @model = @options.fetch(:model, default_model)
      @client = @options.fetch(:client, default_client)
      @api_key = @options.fetch(:api_key, default_client_key)
      @log_errors = @options.fetch(:log_errors, true)
      @organization_id = @options.fetch(:organization_id, default_organization_id)
      @agents_path = @options.fetch(:agents_path, default_agents_path)
      @agent_file_name = @options.fetch(:agent_file_name, default_agent_file_name)
    end

    class << self
      def settings
        @settings ||= new
      end

      def client
        settings.client
      end

      def api_key
        settings.api_key
      end

      def model
        settings.model
      end

      def client_retries
        settings.client_retries
      end

      def log_errors
        settings.log_errors
      end

      def organization_id
        settings.organization_id
      end

      def agents_path
        settings.agents_path
      end

      def agent_file_name
        settings.agent_file_name
      end

      def configure
        yield(settings)
      end

      def reset
        @settings = nil
      end
    end

    def client=(client)
      @client = @options[:client] = client
    end

    def api_key=(api_key)
      @api_key = @options[:api_key] = api_key
    end

    def model=(model)
      @model = @options[:model] = model
    end

    def client_retries=(retries)
      @client_retries = @options[:client_retries] = retries
    end

    def log_errors=(log_errors)
      @log_errors = @options[:log_errors] = log_errors
    end

    def organization_id=(organization_id)
      @organization_id = @options[:organization_id] = organization_id
    end

    def agents_path=(agents_path)
      @agents_path = @options[:agents_path] = agents_path
    end

    def agent_file_name=(agent_file_name)
      @agent_file_name = @options[:agent_file_name] = agent_file_name
    end

    def default_client
      AgentBase::Clients::OpenAI.client
    end

    def default_model
      'gpt-3.5-turbo'
    end

    def default_client_key
      ENV['OPENAI_API_KEY']
    end

    def default_organization_id
      ENV['OPENAI_ORGANIZATION_ID']
    end

    def default_agents_path
      'app/agents'
    end

    def default_agent_file_name
      'agent.rb'
    end
  end
end
