require 'jbuilder'
require_relative '../client'
require_relative '../models/routes'

module ActiveAI
  module Routing
    class << self
      def prompt(json_routes = {})
        <<~PROMPT
          Given the following conversation, classify it into one of the existing routes based on the nature of the interaction and the capabilities demonstrated by the AI assistant. If the conversation does not fit well into any of the predefined routes, suggest a new route, a relevant path and parameters for the category. Additionally, provide a short title (less than 10 words) that summarizes the conversation.
          Existing routes:
          <capabilities>
          #{json_routes}
          </capabilities>

          Conversation:
          <conversation>
          I have this request that needs to be categorized. Could you help me figure out which of the predefined routes it belongs to?
          </conversation>

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

      def init_routes
        resource = ActiveAI::Client.chat(
          parameters: {
            model: ActiveAI::Configuration.model,
            messages: [
              {
                "role": 'system',
                "content": 'You are an AI assistant that can classify conversations into routes.'
              },
              {
                "role": 'user',
                "content": prompt(json_routes)
              }
            ]
          },
          response_model: Models::Routes
        )

        resource.valid? ? true : false
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
