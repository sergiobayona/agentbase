require 'active_ai/clients/openai'
require 'rails'

module ActiveAI
  class Configuration
    attr_reader :api_key, :model, :client_retries, :client

    def initialize(options = {})
      @options = options.dup
      yield(self) if block_given?
      @client_retries = @options.fetch(:client_retries, 1)
      @model = @options.fetch(:model, default_model)
      @client = @options.fetch(:client, default_client)
      @api_key = @options.fetch(:api_key, default_client_key)
      Routing::Router.load_routes! # load routes from the app's active_ai/config/routes.rb file.
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

    def default_client
      ActiveAI::Clients::OpenAI.client
    end

    def default_model
      'gpt-3.5-turbo'
    end

    def default_client_key
      ENV['OPENAI_API_KEY']
    end
  end
end
