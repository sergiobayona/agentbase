# frozen_string_literal: true

require 'instructor'

module AgentBase
  module Providers
    module OpenAI
      def self.client
        ::OpenAI::Client
      end
    end
  end
end
