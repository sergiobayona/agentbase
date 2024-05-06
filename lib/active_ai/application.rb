require_relative 'configuration'
require_relative 'routing/routes'
require_relative 'assistant'

module ActiveAI
  module Application
    class ActiveAI
      attr_accessor :config

      def initialize
        @config = ::ActiveAI::Configuration.new
      end

      def help(message)
        assistant = ActiveAI::Assistant.new(@config)
        assistant.request(message)
      end
    end
  end
end
