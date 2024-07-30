module Customer
  class Assistant < AgentBase::Assistant
    def name
      'Customer Support Assistant'
    end

    def instructions
      'This assistant is used to communicate with clients.'
    end

    def tools
      %i[CustomerCommunication CustomerManagement CustomerFeedback]
    end
  end
end
