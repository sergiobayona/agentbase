# frozen_string_literal: true

module ActiveAI
  module Client
    class << self
      delegate :chat, :assistants, :threads, :messages, :runs, :run_steps, to: :client

      def client
        @client ||= Configuration.client.new(access_token: Configuration.api_key)
      end
    end
  end
end
