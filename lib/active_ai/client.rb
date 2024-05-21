module ActiveAI
  module Client
    class << self
      delegate :chat, :assistants, :threads, :messages, :runs, :run_steps, to: :client

      # def chat(parameters:, response_model: nil)
      #   client.chat(parameters:, response_model:)
      # end
      #
      # def create_assistant(parameters:)
      #   client.assistants.create(parameters:)
      # end

      # def create_thread
      #   client.threads.create
      # end

      # def create_message(thread_id:, parameters:)
      #   client.messages.create(thread_id:, parameters:)
      # end

      # def run_thread(thread_id, assistant_id)
      #   client.runs.create(
      #     thread_id:,
      #     parameters: {
      #       assistant_id:
      #     }
      #   )
      # end

      # def retriev_run(run_id, thread_id)
      #   client.runs.retrieve(id: run_id, thread_id:)
      # end

      def client
        @client ||= Configuration.client.new(access_token: Configuration.api_key)
      end
    end
  end
end
