# frozen_string_literal: true

require 'instructor'

module AgentBase
  module Clients
    module OpenAI
      def self.client
        Instructor.from_openai(::OpenAI::Client)
      end
    end
  end
end
