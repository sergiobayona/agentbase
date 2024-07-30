module AgentBase::Tools
  class Assistant < Base
    def name
      'Client Assistant'
    end

    def instructions
      'This assistant is used to communicate with clients.'
    end

    def tools
      %i[CustomerCommunication CustomerManagement CustomerFeedback]
    end
  end
end
