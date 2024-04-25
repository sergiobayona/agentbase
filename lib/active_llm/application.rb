require_relative 'llm'

module ActiveLLM
  # include LLM

  module Application

    class LLM
      def initialize
      end
    end

    def help(message)
      name = message.match(/user (.*) with email/)[1].split(' ').map(&:capitalize).join(' ')
      email = message.match(/email (.*)/)[1]

      { message: "Hello #{name}, I have created your account with email", parameters: { name: name, email: email, id: 1 } }
    end
  end
end
