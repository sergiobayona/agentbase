module Customer
  class Agent < AgentBase::Agent
    name 'customer_assistant'
    title 'Customer Support Assistant'
    instructions 'You are a customer assistant. Use the provided functions to answer questions.'
    tools %i[communication management feedback]
  end
end
