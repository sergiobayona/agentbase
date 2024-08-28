module Customer
  class Agent < AgentBase::Agent
    name 'customer_agent'
    title 'Customer Support Assistant'
    instructions 'You are a customer assistant. Use the tools provided to answer the customer questions.'
    toolset %i[Customer::Communication Customer::Management Customer::Feedback]
  end
end
