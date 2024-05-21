require 'jbuilder'
require_relative '../client'
require_relative '../models/routes'

module ActiveAI
  module Routing
    @@setup = false
    class << self
      def prompt(json_routes = {})
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
        assistant = Client.assistants.create(
          parameters: {
            model: 'gpt-4o',
            name: 'A system that classifies conversations into routes.',
            instructions: prompt(json_routes),
            tools: [EasyTalk::Tools::FunctionBuilder.new(Models::Routes)]
          }
        )
        assistant_id = assistant['id']
        response = Client.threads.create
        thread_id = response['id']
        message = Client.messages.create(
          thread_id:,
          parameters: {
            role: 'user',
            content: 'Hello, I have a conversation that I would like to classify into a route. Can you help me with that?'
          }
        )
        message_id = message['id']
        run = Client.runs.create(
          thread_id:,
          parameters: {
            assistant_id:
          }
        )
        run_id = run['id']

        while true
          response = Client.runs.retrieve(id: run_id, thread_id:)
          status = response['status']

          case status
          when 'queued', 'in_progress', 'cancelling'
            sleep 1
          when 'completed'
            break
          when 'requires_action'
            # Handle tool calls
          when 'cancelled', 'failed', 'expired'
            puts response['last_error'].inspect
            break
          else
            puts "Unknown status response: #{status}"
          end
        end

        run_steps = Client.run_steps.list(thread_id:, run_id:, parameters: { order: 'asc' })
        new_message_ids = run_steps['data'].filter_map do |step|
          if step['type'] == 'message_creation'
            step.dig('step_details', 'message_creation', 'message_id')
          end # Ignore tool calls, because they don't create new messages.
        end

        # Retrieve the individual messages
        new_messages = new_message_ids.map do |msg_id|
          Client.messages.retrieve(id: msg_id, thread_id:)
        end

        # Find the actual response text in the content array of the messages
        new_messages.each do |msg|
          msg['content'].each do |content_item|
            case content_item['type']
            when 'text'
              puts content_item.dig('text', 'value')
            # Also handle annotations
            when 'image_file'
              # Use File endpoint to retrieve file contents via id
              id = content_item.dig('image_file', 'file_id')
            end
          end
        end
      end

      def setup?
        @@setup
      end

      def json_routes
        Jbuilder.new { |json| json.array! app_routes, *json_args }.target!
      end

      def json_args
        %i[name path parameters phrasing]
      end

      def app_routes
        ActiveAI::Router.app_routes.values
      end
    end
  end
end
