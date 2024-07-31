module Customer
  class Assistant < AgentBase::Assistant
    class << self
      def name
        'customer_assistant'
      end

      def title
        'Customer Support Assistant'
      end

      def description
        'This assistant is used to communicate with clients.'
      end

      def tools
        %w[communication management feedback]
      end
    end
  end
end
