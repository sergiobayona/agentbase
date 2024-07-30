# frozen_string_literal: true

module AgentBase::Tools
  class CustomerCommunication < Base
    # Sends a welcome email to new users.
    # @param user_id [Integer] the id of the user to email.
    def welcome_email(user_id:)
      user = User.find(user_id)
      mailer = UserMailer.with(user:).welcome_email.deliver_now
      render json: mailer
    end
  end
end
