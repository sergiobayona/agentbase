module ActiveAI
  module Client
    class << self
      def chat(parameters:, response_model:)
        client.chat(parameters:, response_model:)
      end

      def client
        @client ||= Configuration.client.new(access_token: Configuration.api_key)
      end
    end
  end
end
