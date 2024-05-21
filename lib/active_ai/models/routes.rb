# frozen_string_literal: true

require 'instructor'
module ActiveAI
  module Models
    class Params
      include EasyTalk::Model

      define_schema do
        title 'system_params'
        property :key, T.nilable(String), description: 'The parameter key'
        property :value, T.nilable(String), description: 'The parameter value'
      end
    end

    class Routes
      include EasyTalk::Model

      def self.name
        'system_routes'
      end

      define_schema do
        property :name, String, description: 'The name of the route'
        property :path, String, description: 'The path to the route'
        property :parameters, T.nilable(Params), description: 'The parameters for the route'
        property :title, String, description: 'A short description of the conversation'
      end
    end
  end
end
