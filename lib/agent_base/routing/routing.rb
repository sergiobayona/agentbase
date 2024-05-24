# frozen_string_literal: true

require 'jbuilder'
require_relative '../client'
require_relative '../models/routes'
require 'event_stream_parser'

module AgentBase
  module Routing
    @@setup = false

    class Assistant
      def prompt(json_routes)
        <<~PROMPT
          Given the following conversation, classify it into one of the existing routes based on the nature of the interaction and the capabilities demonstrated by the AI assistant. If the conversation does not fit well into any of the predefined routes, suggest a new route, a relevant path and parameters for the category. Additionally, provide a short title (less than 10 words) that summarizes the conversation.
          Existing routes:
          <capabilities>
          #{json_routes}
          </capabilities>

          If the conversation fits into an existing route, provide the following:
          - Name: [The name of the route]
          - Path: [The path to the route]
          - Parameters: [a set of key-value pairs for parameters in snake_case]
          - Title: [A short descriptive and specific title summarizing the conversation in less than 10 words]
          If the conversation does not fit well into any existing route, provide the following:
          - Topic: [Propose a name for the new category in snake_case]
          - Path: [Propose a path in snake_case, separated by commas]
          - Parameters: [Propose a set of key-value pairs for parameters in snake_case]
          - Title: [A short descriptive and specific title summarizing the conversation in less than 10 words]
        PROMPT
      end

      def setup
        assistant = new
        assistant.create
        assistant.create_thread
        assistant.create_message
        create_run
        @@setup = true
      end

      def setup?
        @@setup
      end

      private

      def create
        assistant = Client.assistants.create(
          parameters: {
            model: 'gpt-4o',
            name: 'A system that classifies conversations into routes.',
            instructions: prompt(json_routes),
            tools: [EasyTalk::Tools::FunctionBuilder.new(Models::Routes)]
          }
        )
        @assistant_id = assistant['id']
      end

      def create_thread
        response = Client.threads.create
        @thread_id = response['id']
      end

      def create_message
        message = Client.messages.create(
          thread_id: @thread_id,
          parameters: {
            role: 'user',
            content: 'Hello, I have a conversation that I would like to classify into a route. Can you help me with that?'
          }
        )
        @message_id = message['id']
      end

      def parse(chunk)
        return unless chunk['status'] == 'completed'

        puts chunk.dig('content', 0, 'text', 'value')
      end

      def create_run
        run = Client.runs.create(
          thread_id: @thread_id,
          parameters: {
            assistant_id: @assistant_id,
            stream: proc { |chunk, _b| parse(chunk) }
          }
        )

        @run_id = run['id']
      end

      def json_routes
        Jbuilder.new { |json| json.array! app_routes, *json_args }.target!
      end

      def json_args
        %i[name path parameters phrasing]
      end

      def app_routes
        AgentBase::Router.app_routes.values
      end
    end
  end
end
