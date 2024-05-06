module ActiveAI
  module Clients
    module OpenAI
      def self.client
        Instructor.patch(::OpenAI::Client)
      end
    end
  end
end
