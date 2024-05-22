# frozen_string_literal: true

require 'jbuilder'
require_relative '../client'
require_relative '../models/routes'
require 'event_stream_parser'

module ActiveAI
  module Routing
    MAX_ATTEMPTS = 5
    SLEEP_INTERVAL = 1
    STATUSES = {
      queued: 'queued',
      in_progress: 'in_progress',
      cancelling: 'cancelling',
      completed: 'completed',
      requires_action: 'requires_action',
      cancelled: 'cancelled',
      failed: 'failed',
      expired: 'expired'
    }.freeze

    @@setup = false

    class << self
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
        create_assistant
        create_thread
        create_message
        create_run
        # wait_for_run_to_complete
        # retrieve_run_steps
        # retrieve_new_messages
        # print_new_messages
        @@setup = true
      end

      def setup?
        @@setup
      end

      private

      def create_assistant
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
        puts chunk while chunk
      end

      def create_run
        run = Client.runs.create(
          thread_id: @thread_id,
          parameters: {
            assistant_id: @assistant_id,
            stream: proc do |chunk, _b|
                      parse(chunk)
                    end
          }
        )

        @run_id = run['id']
      end

      def wait_for_run_to_complete
        attempts = 0
        while attempts < MAX_ATTEMPTS
          response = Client.runs.retrieve(id: @run_id, thread_id: @thread_id)
          status = response['status']

          case status
          when STATUSES[:queued], STATUSES[:in_progress], STATUSES[:cancelling]
            sleep SLEEP_INTERVAL
          when STATUSES[:completed], STATUSES[:requires_action], STATUSES[:cancelled], STATUSES[:failed], STATUSES[:expired]
            break
          else
            puts "Unknown status response: #{status}"
          end
          attempts += 1
        end
      end

      def retrieve_run_steps
        @run_steps = Client.run_steps.list(thread_id: @thread_id, run_id: @run_id, parameters: { order: 'asc' })
      end

      def retrieve_new_messages
        new_message_ids = @run_steps['data'].filter_map do |step|
          step.dig('step_details', 'message_creation', 'message_id') if step['type'] == 'message_creation'
        end

        @new_messages = new_message_ids.map do |msg_id|
          Client.messages.retrieve(id: msg_id, thread_id: @thread_id)
        end
      end

      def print_new_messages
        @new_messages.each do |msg|
          msg['content'].each do |content_item|
            case content_item['type']
            when 'text'
              puts content_item.dig('text', 'value')
            when 'image_file'
              content_item.dig('image_file', 'file_id')
            end
          end
        end
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
