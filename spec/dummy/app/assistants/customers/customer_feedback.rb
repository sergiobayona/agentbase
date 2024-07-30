module AgentBase::Tools
  class CustomerFeedback < Base
    # Sends a feedback email to customers.
    # @param customer_id [Integer] the id of the customer to email.
    def receive_feedback(customer_id:, feedback:)
      customer = Customer.find(customer_id)
      feedback = Feedback.create!(customer:, feedback:)
      render json: { message: 'thank the customer for their feedback' }
    end
  end
end
