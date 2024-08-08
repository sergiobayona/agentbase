module Customer
  class Agent < AgentBase::Agent
    class << self
      def name
        'customer_assistant'
      end

      def title
        'Customer Support Assistant'
      end

      def instructions
        'You are a customer assistant. Use the provided functions to answer questions.'
      end

      def tools
        %w[communication management feedback]
      end
    end
  end
end
