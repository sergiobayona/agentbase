module Customer
  class Agent < AgentBase::Agent
    name 'customer_assistant'
    title 'Customer Support Assistant'
    instructions 'You are a customer assistant. Use the tools provided to answer the customer questions.'
    toolset %i[communication management feedback]
  end
end
