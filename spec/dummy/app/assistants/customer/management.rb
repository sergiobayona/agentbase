# frozen_string_literal: true

module Customer
  class Management < AgentBase::Tools::Base
    # Shows the user record from the database.
    # @param user_id [Integer] the id of the user to show.
    def show(user_id)
      @user = AgentBase::Models::User.find(user_id)
      render json: @user
    end

    # Creates a new user record in the database.
    # @param user_params [Hash] the attributes of the user to create.
    def create(user_params)
      @user = User.new(user_params)
      if @user.save
        render json: @user, template: 'show'
      else
        render json: @user.errors
      end
    end

    # Authenticates a user by sending an special link via email.
    # @param email [String] the email of the user to authenticate.
    def authenticate(email:)
      @user = User.find_by_email(email)
      if @user
        @user.send_authentication_email
        render json: { message: 'Authentication email sent. Please tell the user to check their email and follow the instructions.' }
      else
        render json: { authenticated: false, error: 'User not found' }
      end
    end
  end
end
